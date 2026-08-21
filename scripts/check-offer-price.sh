#!/usr/bin/env bash
# Verifica en producción que las 8 landings de eventos de empresa tienen
# price en el Offer y que ese precio coincide con el que ve el usuario.
# Uso: scripts/check-offer-price.sh [base-url]
set -uo pipefail

BASE="${1:-https://www.rentboatmarbella.com}"
FAIL=0

# slug|precio visible esperado (formato del locale, ver README)
PAGES=(
  "eventos-empresa-barco-marbella|1.200€"
  "corporate-events-boat-marbella|€1,200"
  "evenements-entreprise-bateau-marbella|1 200 €"
  "korporativy-yakhta-marbella|1 200 €"
  "eventi-aziendali-barca-marbella|1.200 €"
  "bedrijfsuitje-boot-marbella|€ 1.200"
  "firmenevent-boot-marbella|1.200 €"
  "faaliyat-al-sharikat-yakht-marbella|1,200 €"
)

for entry in "${PAGES[@]}"; do
  slug="${entry%%|*}"
  want="${entry##*|}"
  url="$BASE/$slug"
  code=$(curl -s -o /dev/null -w '%{http_code}' "$url?cb=$RANDOM")
  # Un servidor local (python3 -m http.server) no replica el cleanUrls de
  # Vercel: si la ruta limpia da 404, reintenta con .html.
  if [ "$code" != "200" ]; then
    url="$BASE/$slug.html"
    code=$(curl -s -o /dev/null -w '%{http_code}' "$url?cb=$RANDOM")
  fi
  if [ "$code" != "200" ]; then
    FAIL=$((FAIL+1))
    printf 'FALLO %-42s HTTP %s\n' "$slug" "$code"
    continue
  fi
  html=$(curl -s "$url?cb=$RANDOM")

  offer=$(printf '%s' "$html" | grep -o '"offers":{[^}]*}' | head -1)
  # cuerpo visible = HTML sin los bloques <script>
  body=$(printf '%s' "$html" | perl -0777 -pe 's{<script.*?</script>}{ }gis')

  schema_ok=0; visible_ok=0
  printf '%s' "$offer" | grep -q '"price":"1200"' && \
    printf '%s' "$offer" | grep -q '"priceCurrency":"EUR"' && schema_ok=1
  printf '%s' "$body" | grep -qF "$want" && visible_ok=1

  if [ $schema_ok -eq 1 ] && [ $visible_ok -eq 1 ]; then
    printf 'ok    %-42s schema price=1200 EUR · visible "%s"\n' "$slug" "$want"
  else
    FAIL=$((FAIL+1))
    printf 'FALLO %-42s schema=%s visible=%s\n' "$slug" \
      "$([ $schema_ok -eq 1 ] && echo ok || echo NO)" \
      "$([ $visible_ok -eq 1 ] && echo ok || echo NO)"
    [ $schema_ok -eq 0 ] && printf '        offer: %s\n' "${offer:-<no encontrado>}"
  fi
done

echo "----"
if [ $FAIL -eq 0 ]; then
  echo "✅ Las 8 páginas: price en el Offer y precio visible coincidente."
else
  echo "❌ $FAIL página(s) con el Offer o el precio visible incorrectos."
  exit 1
fi
