#!/usr/bin/env bash
#
# check-links.sh — salvaguarda anti-regresión.
#
# Hace curl a TODAS las URLs internas enlazadas desde los índices del blog
# (ES/EN/FR/RU) y falla (exit 1) si alguna no responde 200. Sirve para detectar
# los 404 de /post/... antes de un push a main (ya ha ocurrido dos veces).
#
# Uso:
#   scripts/check-links.sh                 # comprueba producción
#   scripts/check-links.sh http://127.0.0.1:8000   # comprueba un servidor local
#
set -uo pipefail

BASE="${1:-https://www.rentboatmarbella.com}"
BASE="${BASE%/}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

INDEXES=(blog-nautico-marbella.html yacht-blog.html blog-nautique.html morskoy-blog.html)

# Rutas internas enlazadas desde los índices del blog (excluye assets y anclas)
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
while IFS= read -r path; do
  [ -z "$path" ] && continue
  total=$((total + 1))
  code=$(curl -s -o /dev/null -L --max-time 25 -w '%{http_code}' "$BASE$path")
  if [ "$code" = "200" ]; then
    printf 'ok    %s  %s%s\n' "$code" "$BASE" "$path"
  else
    printf 'FAIL  %s  %s%s\n' "$code" "$BASE" "$path"
    fail=$((fail + 1))
  fi
done <<< "$paths"

echo "----"
echo "Comprobadas: $total · Fallos: $fail · Base: $BASE"
if [ "$fail" -ne 0 ]; then
  echo "❌ Hay URLs enlazadas desde el blog que NO responden 200. NO hacer push a main."
  exit 1
fi
echo "✅ Todas las URLs enlazadas desde el blog responden 200."
