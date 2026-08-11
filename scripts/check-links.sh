#!/usr/bin/env bash
#
# check-links.sh — salvaguarda anti-regresión (con cache-buster).
#
# FASE 1 (offline) — huérfanos: comprueba que toda URL /post/ del sitemap esté
# enlazada desde el índice de blog de SU idioma.
#
# FASE 2 (red) — hace curl a TODAS las URLs internas enlazadas desde los índices
# del blog (ES/EN/FR/RU), añadiendo un cache-buster (?cb=...) para NO validar
# nunca contra la caché de edge de Vercel, y falla (exit 1) si alguna no
# responde 200. Reporta también x-vercel-cache (esperado MISS por el cache-buster).
#
# Las dos fases son complementarias y NINGUNA cubre lo de la otra: la fase 2
# parte de los hrefs de los índices, así que un post publicado y en el sitemap
# pero al que ningún índice enlaza respondía 200 sin que nadie lo mirase —
# invisible para el usuario en el blog y casi huérfano para Google. Eso es lo
# que detecta la fase 1.
#
# Uso:
#   scripts/check-links.sh                        # producción
#   scripts/check-links.sh http://127.0.0.1:8000  # servidor local
#
set -uo pipefail

BASE="${1:-https://www.rentboatmarbella.com}"
BASE="${BASE%/}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

INDEXES=(blog-nautico-marbella.html yacht-blog.html blog-nautique.html morskoy-blog.html)

paths=$(for f in "${INDEXES[@]}"; do
          [ -f "$ROOT/$f" ] && grep -ohE 'href="/[^"#?]*"' "$ROOT/$f"
        done \
        | sed -E 's/^href="//; s/"$//' \
        | grep -vE '\.(png|jpg|jpeg|webp|avif|svg|css|js|xml|ico|txt|json)$' \
        | sort -u)

if [ -z "$paths" ]; then
  echo "No se encontraron índices de blog en $ROOT — nada que comprobar." >&2
  exit 2
fi

# ---------------------------------------------------------------------------
# FASE 1 — huérfanos del sitemap (offline, sin red).
#
# Para cada <loc> .../post/<slug> del sitemap se lee el idioma del propio post
# (<html lang="xx">) y se exige que su índice enlace a /post/<slug>.
# Mapa idioma -> índice: es→blog-nautico-marbella, en→yacht-blog,
# fr→blog-nautique, ru→morskoy-blog.
# ---------------------------------------------------------------------------
index_for_lang() {
  case "$1" in
    es) echo "blog-nautico-marbella.html" ;;
    en) echo "yacht-blog.html" ;;
    fr) echo "blog-nautique.html" ;;
    ru) echo "morskoy-blog.html" ;;
    *)  echo "" ;;
  esac
}

orphan_fail=0; orphan_total=0
if [ ! -f "$ROOT/sitemap.xml" ]; then
  echo "· Sin sitemap.xml en $ROOT — se omite la comprobación de huérfanos."
else
  echo "== Fase 1: posts del sitemap enlazados desde su índice =="
  slugs=$(grep -oE '<loc>[^<]*/post/[^<]*</loc>' "$ROOT/sitemap.xml" \
          | sed -E 's#.*/post/##; s#</loc>##; s#/$##' \
          | sort -u)
  while IFS= read -r slug; do
    [ -z "$slug" ] && continue
    orphan_total=$((orphan_total + 1))
    post="$ROOT/post/$slug.html"
    if [ ! -f "$post" ]; then
      printf 'FAIL  el sitemap lista /post/%s pero no existe post/%s.html\n' "$slug" "$slug"
      orphan_fail=$((orphan_fail + 1))
      continue
    fi
    lang="$(grep -oE '<html[^>]*lang="[a-zA-Z-]+"' "$post" | head -1 \
            | sed -E 's/.*lang="([a-zA-Z]+).*/\1/' | tr '[:upper:]' '[:lower:]')"
    idx="$(index_for_lang "$lang")"
    if [ -z "$idx" ]; then
      printf 'FAIL  /post/%s: idioma no reconocido (<html lang="%s">)\n' "$slug" "${lang:-?}"
      orphan_fail=$((orphan_fail + 1))
    elif [ ! -f "$ROOT/$idx" ]; then
      printf 'FAIL  /post/%s (%s): falta el índice %s\n' "$slug" "$lang" "$idx"
      orphan_fail=$((orphan_fail + 1))
    elif grep -q "href=\"/post/$slug\"" "$ROOT/$idx"; then
      printf 'ok    %-3s  /post/%-45s enlazado desde %s\n' "$lang" "$slug" "$idx"
    else
      printf 'FAIL  %-3s  /post/%-45s NO enlazado desde %s\n' "$lang" "$slug" "$idx"
      orphan_fail=$((orphan_fail + 1))
    fi
  done <<< "$slugs"
  echo "Posts del sitemap: $orphan_total · Huérfanos: $orphan_fail"
  if [ "$orphan_fail" -ne 0 ]; then
    echo "❌ Hay posts en el sitemap sin card en su índice de blog. NO hacer push a main."
    echo "   (existen y responden 200, pero nadie llega a ellos desde el blog)."
  fi
  echo
fi

echo "== Fase 2: las URLs enlazadas desde los índices responden 200 =="
fail=0; total=0
ts="$(date +%s)"
while IFS= read -r path; do
  [ -z "$path" ] && continue
  total=$((total + 1))
  # Reintentos: evita falsos positivos por timeouts transitorios (p. ej. cache
  # MISS lento justo tras un redeploy). Solo se considera FAIL si tras 3 intentos
  # no se obtiene 200.
  code=""; vcache=""
  for attempt in 1 2 3; do
    # cache-buster único por intento -> Vercel lo trata como URL nueva
    url="$BASE$path?cb=${ts}-${total}-${attempt}-${RANDOM}"
    headers="$(curl -sIL --max-time 40 --retry 2 --retry-delay 1 "$url")"
    code="$(printf '%s' "$headers" | awk 'toupper($1) ~ /^HTTP/ {c=$2} END{print c}')"
    vcache="$(printf '%s' "$headers" | awk 'tolower($1) ~ /^x-vercel-cache:/ {v=$2} END{print v}' | tr -d '\r')"
    [ "$code" = "200" ] && break
    sleep 1
  done
  if [ "$code" = "200" ]; then
    printf 'ok    %s  x-vercel-cache=%-6s  %s%s\n' "$code" "${vcache:-n/a}" "$BASE" "$path"
  else
    printf 'FAIL  %s  x-vercel-cache=%-6s  %s%s\n' "${code:-timeout}" "${vcache:-n/a}" "$BASE" "$path"
    fail=$((fail + 1))
  fi
done <<< "$paths"

echo "----"
echo "Comprobadas: $total · Fallos: $fail · Base: $BASE (con cache-buster)"
echo "Posts del sitemap: $orphan_total · Huérfanos: $orphan_fail"
if [ "$fail" -ne 0 ]; then
  echo "❌ Hay URLs enlazadas desde el blog que NO responden 200. NO hacer push a main."
fi
if [ "$orphan_fail" -ne 0 ]; then
  echo "❌ Hay posts en el sitemap sin card en su índice de blog. NO hacer push a main."
fi
if [ "$fail" -ne 0 ] || [ "$orphan_fail" -ne 0 ]; then
  exit 1
fi
echo "✅ Todas las URLs enlazadas desde el blog responden 200 (con cache-buster)."
echo "✅ Todos los posts del sitemap tienen card en su índice de idioma."
