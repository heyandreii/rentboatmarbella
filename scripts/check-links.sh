#!/usr/bin/env bash
#
# check-links.sh — salvaguarda anti-regresión (con cache-buster).
#
# Hace curl a TODAS las URLs internas enlazadas desde los índices del blog
# (ES/EN/FR/RU), añadiendo un cache-buster (?cb=...) para NO validar nunca contra
# la caché de edge de Vercel, y falla (exit 1) si alguna no responde 200.
# Reporta también x-vercel-cache (esperado MISS por el cache-buster).
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
if [ "$fail" -ne 0 ]; then
  echo "❌ Hay URLs enlazadas desde el blog que NO responden 200. NO hacer push a main."
  exit 1
fi
echo "✅ Todas las URLs enlazadas desde el blog responden 200 (con cache-buster)."
