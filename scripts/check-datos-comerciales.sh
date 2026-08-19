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
#   incluido más allá de UNA botella de champán de cortesía · tarifa de 6 h.
#
# Y la redacción VIEJA del champán: hasta el 19/08/2026 lo incluido era una
# "copa" de champán y ese mismo día el propietario lo subió a "botella". La copa
# queda prohibida en los 8 idiomas: si reaparece, es una regresión, no un dato.
# Ojo, las menciones AMBIENTALES de champán (decoración, extras, "brindis con
# champán") son legítimas y no se buscan aquí — solo la copa "de cortesía".
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
equipo|es|altavoz|altavoces|barra premium|barra libre premium|bebida fría
equipo|en|portable speaker|premium bar|dj set|cold drinks included
equipo|fr|enceinte portable|bar premium|boissons fraîches incluses
equipo|ru|переносн\w+ колонк|премиум-бар
equipo|it|cassa portatile|open bar premium|bevande fredde incluse
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
colchoneta|ru|(надувной|плавучий|плавающий) матрас
colchoneta|it|materassino
alcohol|es|barra libre|alcohol incluido|bebidas alcohólicas incluidas
alcohol|en|open bar|alcohol included|alcoholic drinks included
alcohol|fr|open bar|alcool inclus|boissons alcoolisées incluses
alcohol|ru|открытый бар|алкоголь включ
alcohol|it|open bar|alcolici inclusi|bevande alcoliche incluse
tarifa6h|xx|6 ?h(oras|ours|eures)? ?[·–-] ?2[.,]400|2[.,]400 ?€|€ ?2[.,]400
copavieja|es|copa de champ[aá]n|copa de champagne
copavieja|en|(complimentary |free )?glass of champagne
copavieja|fr|coupe de champagne (offerte|incluse)
copavieja|ru|бокал\w* шампанского в подарок
copavieja|it|calice di champagne
copavieja|nl|glas champagne van het huis
copavieja|de|Glas Champagner als Aufmerksamkeit
PATTERNS

# Los globos solo pueden aparecer dentro del extra de decoración especial, así
# que se listan aparte para revisarlos a mano en vez de darlos por rotos.
GLOBOS='globos|balloons|ballons|шар(ы|ики)|palloncini'

# La MÚSICA es zona gris y por eso no rompe el build: no hay equipo de sonido a
# bordo (confirmado 19/08/2026), pero el cliente puede llevar el suyo y eso no
# está ni confirmado ni desmentido. Lo que sí es un claim prohibido —altavoz que
# pongamos nosotros, barra premium con DJ— va arriba, en los patrones duros.
# Estas líneas se revisan a mano: "música a bordo" promete equipo, "vuestra
# música" no necesariamente. Pendiente de que el propietario aclare si se puede
# subir un altavoz propio (ver §5 de ESTADO.md).
MUSICA='m[uú]sica a bordo|music on board|musique à bord|музыка на борту|musica a bordo'

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
echo "== Música a bordo (zona gris: no hay equipo de sonido, revisar a mano) =="
m="$(grep -rniE "$MUSICA" --include='*.html' . 2>/dev/null | grep -vE '<!--' || true)"
if [ -n "$m" ]; then
  printf '%s\n' "$m" | cut -c1-160 | sed 's/^/      /'
  echo "      ^ NO rompe el build. Cada línea debe poder cumplirse sin equipo de"
  echo "        sonido de la casa. Ver la nota de este script y §5 de ESTADO.md."
else
  echo "ok    ninguna mención."
fi

echo
if [ "$fail" -ne 0 ]; then
  echo "❌ Hay datos comerciales sin confirmar publicados. NO hacer push a main."
  exit 1
fi
echo "✅ Ningún claim prohibido en el HTML publicado."
