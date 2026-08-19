#!/usr/bin/env bash
#
# check-datos-comerciales.sh — grep anti-invención (offline, sin red).
#
# Busca en TODO el HTML publicado los claims que el propietario confirmó que
# NO son ciertos (ver "Regla anti-invención" en README.md, §6 de ESTADO.md).
# Existe porque el sitio ya publicó tres veces cosas que no hay a bordo, y
# porque cada oleada de idioma nuevo multiplica la superficie donde puede
# volver a colarse: un patrón por idioma, no una revisión a ojo.
#
# Qué NO hay a bordo (confirmado 19/08/2026):
#   equipo de sonido / Bluetooth · nevera · ducha de agua dulce · colchoneta
#   flotante · hielo · política de descorche (subir bebida propia) · globos
#   sueltos (solo dentro del extra "decoración especial +120 €") · alcohol
#   incluido más allá de UNA copa de champán de cortesía · tarifa de 6 h.
#
# Uso:  scripts/check-datos-comerciales.sh
# Sale 1 si encuentra algo. Los comentarios HTML (<!-- ... -->) se ignoran:
# ahí sí se documenta lo que no existe, que es justo para lo que sirven.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0

# Un patrón por línea:  <etiqueta>|<idioma>|<regex extendida>
# Las regex van con -i (case-insensitive) y sobre el HTML tal cual se sirve.
read -r -d '' RULES <<'PATTERNS'
sonido|es|equipo de sonido|altavoces a bordo|bluetooth
sonido|en|sound system|bluetooth speaker|on-?board (sound|speakers)
sonido|fr|système (audio|de son)|enceinte (bluetooth|à bord)
sonido|ru|аудиосистем|блютуз|колонк[аи] на борту
sonido|it|impianto (audio|stereo)|casse (bluetooth|a bordo)|bluetooth
nevera|es|nevera a bordo|nevera incluida|frigorífico
nevera|en|(fridge|refrigerator|cool ?box|ice ?box) (on board|included)|on-?board fridge
nevera|fr|(frigo|réfrigérateur|glacière) (à bord|inclus)
nevera|ru|холодильник на борту|холодильник включ
nevera|it|(frigorifero|frigo|ghiacciaia) (a bordo|incluso)
hielo|es|agua y hielo|hielo incluido|con hielo
hielo|en|water and ice|ice included|ice buckets?
hielo|fr|eau et glaçons|glaçons inclus|seau à glace
hielo|ru|вода и лёд|со льдом|лёд включ
hielo|it|acqua e ghiaccio|ghiaccio incluso|con ghiaccio|secchiello del ghiaccio
descorche|es|descorche|traer (tu|vuestra|su|vuestras|sus) propia?s? bebidas?|subir (tu|vuestra) bebida
descorche|en|corkage|bring your own (drinks?|cava|wine|bottles?|booze|alcohol)
descorche|fr|droit de bouchon|apporter (vos|votre) (propres? )?boissons?
descorche|ru|со своим алкоголем|свои напитки|своими напитками
descorche|it|diritto di tappo|portare (le |i )?(vostr[ie] )?(bevande|alcolici|bottiglie) da casa
ducha|es|ducha de agua dulce
ducha|en|fresh ?water shower
ducha|fr|douche (à |d.)eau douce
ducha|ru|пресн(ый|ого) душ
ducha|it|doccia (di |ad )?acqua dolce
colchoneta|es|colchoneta
colchoneta|en|floating mat|inflatable mat
colchoneta|fr|matelas (flottant|gonflable)
colchoneta|ru|надувной матрас
colchoneta|it|materassino
alcohol|es|barra libre|alcohol incluido|bebidas alcohólicas incluidas
alcohol|en|open bar|alcohol included|alcoholic drinks included
alcohol|fr|open bar|alcool inclus|boissons alcoolisées incluses
alcohol|ru|открытый бар|алкоголь включ
alcohol|it|open bar|alcolici inclusi|bevande alcoliche incluse
tarifa6h|xx|6 ?h(oras|ours|eures)? ?[·–-] ?2[.,]400|2[.,]400 ?€|€ ?2[.,]400
PATTERNS

# Los globos solo pueden aparecer dentro del extra de decoración especial, así
# que se listan aparte para revisarlos a mano en vez de darlos por rotos.
GLOBOS='globos|balloons|ballons|шар(ы|ики)|palloncini'

echo "== Claims prohibidos =="
while IFS='|' read -r tag lang rest; do
  [ -z "${tag:-}" ] && continue
  hits="$(grep -rniE "$rest" --include='*.html' . 2>/dev/null \
          | grep -vE '<!--' || true)"
  if [ -n "$hits" ]; then
    printf '\nFAIL  [%s/%s]  %s\n' "$tag" "$lang" "$rest"
    printf '%s\n' "$hits" | cut -c1-200 | sed 's/^/      /'
    fail=$((fail + 1))
  fi
done <<< "$RULES"
[ "$fail" -eq 0 ] && echo "ok    0 hits fuera de comentarios."

echo
echo "== Globos (solo válidos dentro del extra «decoración especial +120 €») =="
g="$(grep -rniE "$GLOBOS" --include='*.html' . 2>/dev/null | grep -vE '<!--' || true)"
if [ -n "$g" ]; then
  printf '%s\n' "$g" | cut -c1-200 | sed 's/^/      /'
  echo "      ^ revisar a mano: cada línea debe estar dentro del extra de decoración."
else
  echo "ok    ninguna mención suelta."
fi

echo
if [ "$fail" -ne 0 ]; then
  echo "❌ Hay datos comerciales sin confirmar publicados. NO hacer push a main."
  exit 1
fi
echo "✅ Ningún claim prohibido en el HTML publicado."
