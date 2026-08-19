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
#   nevera · ducha de agua dulce · colchoneta flotante · hielo · política de
#   descorche (subir bebida propia) · globos sueltos (solo dentro del extra
#   "decoración especial +120 €") · alcohol incluido más allá de UNA botella de
#   champán de cortesía · tarifa de 6 h.
#
# SÍ hay equipo de sonido (aclarado por el propietario el 19/08/2026, corrige la
# confirmación anterior): equipo de sonido con Bluetooth, el cliente conecta su
# propia música. Dejó de ser claim prohibido y pasa a ser claim CONFIRMADO: aquí
# ya no se busca que desaparezca, se busca que aparezca con la redacción canónica
# del README y nunca acompañado de lo que sigue sin existir — DJ, barra premium,
# altavoz portátil que preste la casa, karaoke.
#
# NO existe descuento ni tarifa de temporada baja (confirmado 19/08/2026): la
# tarifa es la misma todo el año (2 h 1.200 € · 4 h 1.800 € · 8 h 3.000 €). El
# post de invierno la prometía en ES y EN —incluida la ficha del buscador— y ahí
# nace el patrón "temporada". Ojo al redactarlo: las NEGACIONES son legítimas y
# no deben casar ("geen korting", "sin descuento"), por eso los patrones piden
# la forma afirmativa completa y no la palabra suelta.
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
equipo|es|altavoz portátil|barra premium|barra libre premium|bebida fría|dj a bordo|karaoke
equipo|en|portable speaker|premium bar|dj set|dj on board|cold drinks included|karaoke
equipo|fr|enceinte portable|bar premium|dj à bord|boissons fraîches incluses|karaoké
equipo|ru|переносн\w+ колонк|премиум-бар|диджей на борту|караоке
equipo|it|cassa portatile|open bar premium|dj a bordo|bevande fredde incluse|karaoke
equipo|nl|draagbare speaker|premium bar|dj aan boord|koude drankjes inbegrepen|karaoke
nevera|es|nevera a bordo|nevera incluida|frigorífico
nevera|en|(fridge|refrigerator|cool ?box|ice ?box) (on board|included)|on-?board fridge
nevera|fr|(frigo|réfrigérateur|glacière) (à bord|inclus)
nevera|ru|холодильник на борту|холодильник включ
nevera|it|(frigorifero|frigo|ghiacciaia) (a bordo|incluso)
nevera|nl|koelkast (aan boord|inbegrepen)|koelbox aan boord|minibar aan boord
hielo|es|agua y hielo|hielo incluido|con hielo
hielo|en|water and ice|ice included|ice buckets?
hielo|fr|eau et glaçons|glaçons inclus|seau à glace
hielo|ru|вода и лёд|со льдом|лёд включ
hielo|it|acqua e ghiaccio|ghiaccio incluso|con ghiaccio|secchiello del ghiaccio
hielo|nl|water en ijs\b|\bijs inbegrepen|ijsemmer|ijsblokjes|\bijs aan boord
descorche|es|descorche|traer (tu|vuestra|su|vuestras|sus) propia?s? bebidas?|subir (tu|vuestra) bebida
descorche|en|corkage|bring your own (drinks?|cava|wine|bottles?|booze|alcohol)
descorche|fr|droit de bouchon|apporter (vos|votre) (propres? )?boissons?
descorche|ru|со своим алкоголем|свои напитки|своими напитками
descorche|it|diritto di tappo|portare (le |i )?(vostr[ie] )?(bevande|alcolici|bottiglie) da casa
descorche|nl|kurkengeld|(eigen|zelf) (drank|drankjes|flessen) (mee|meenemen)|neem je eigen drank
ducha|es|ducha de agua dulce
ducha|en|fresh ?water shower
ducha|fr|douche (à |d.)eau douce
ducha|ru|пресн(ый|ого) душ
ducha|it|doccia (di |ad )?acqua dolce
ducha|nl|zoetwaterdouche|douche aan boord
colchoneta|es|colchoneta
colchoneta|en|floating mat|inflatable mat
colchoneta|fr|matelas (flottant|gonflable)
colchoneta|ru|(надувной|плавучий|плавающий) матрас
colchoneta|it|materassino
colchoneta|nl|opblaasmatras|drijfmatras|luchtbed
alcohol|es|barra libre|alcohol incluido|bebidas alcohólicas incluidas
alcohol|en|open bar|alcohol included|alcoholic drinks included
alcohol|fr|open bar|alcool inclus|boissons alcoolisées incluses
alcohol|ru|открытый бар|алкоголь включ
alcohol|it|open bar|alcolici inclusi|bevande alcoliche incluse
alcohol|nl|open bar|alcohol inbegrepen|alcoholische dranken inbegrepen|onbeperkt drinken
tarifa6h|xx|6 ?h(oras|ours|eures)? ?[·–-] ?2[.,]400|2[.,]400 ?€|€ ?2[.,]400
temporada|es|descuentos? de temporada|precios especiales|tarifas? reducidas?|precios? reducidos?|oferta de temporada|más barato en (invierno|temporada baja)|barco premium por menos
temporada|en|(seasonal|winter|low.season) discounts?|special rates?|special prices?|lower prices?|cheaper in (winter|the low season)|premium boat for less
temporada|fr|réductions? de saison|prix réduits?|tarifs réduits|prix spéciaux|moins cher en (hiver|basse saison)
temporada|ru|скидк\w* (в|на) (низкий|зимн)|специальные цены|дешевле (зимой|в низкий сезон)
temporada|it|sconti? (di |in )?(stagione|bassa stagione|inverno)|prezzi ridotti|prezzi speciali|più economico in (inverno|bassa stagione)
temporada|nl|korting(en)? (in|voor) (de winter|het laagseizoen)|winterkorting|lagere prijs|speciale prijzen
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
GLOBOS='globos|balloons|ballons|шар(ы|ики)|palloncini|ballonnen'

# El equipo de sonido es un claim CONFIRMADO con redacción canónica (README →
# "Regla anti-invención"). Aquí no se busca su ausencia sino su deriva: cualquier
# mención del equipo tiene que usar una de las formas canónicas. Se comprueba que
# toda línea que nombra el equipo contenga "Bluetooth", que es la palabra que las
# siete redacciones comparten; una mención sin ella es una reescritura a mano y
# hay que revisarla.
SONIDO_MENCION='equipo de sonido|sound system|système audio|аудиосистем|impianto audio|geluidssysteem|Soundsystem'

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
echo "== Equipo de sonido: claim confirmado, redacción canónica =="
desviadas="$(grep -rniE "$SONIDO_MENCION" --include='*.html' . 2>/dev/null \
             | grep -vE '<!--' | grep -viE 'bluetooth' || true)"
if [ -n "$desviadas" ]; then
  printf '\nFAIL  [sonido/canonica]  mención del equipo sin "Bluetooth"\n'
  printf '%s\n' "$desviadas" | cut -c1-200 | sed 's/^/      /'
  echo "      ^ usa la redacción canónica del README (\"Regla anti-invención\")."
  fail=$((fail + 1))
else
  n="$(grep -rliE "$SONIDO_MENCION" --include='*.html' . 2>/dev/null | wc -l | tr -d ' ')"
  echo "ok    $n páginas lo mencionan y todas con la redacción canónica."
fi

echo
if [ "$fail" -ne 0 ]; then
  echo "❌ Hay datos comerciales sin confirmar publicados. NO hacer push a main."
  exit 1
fi
echo "✅ Ningún claim prohibido en el HTML publicado."
