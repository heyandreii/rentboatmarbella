# rentboatmarbella.com

Sitio estático (HTML) de alquiler de barco privado en Marbella (De Antonio D50).
Desplegado en **Vercel** desde la rama `main` de GitHub. Sin framework ni build:
los `.html` se sirven tal cual (con `cleanUrls: true`, ver `vercel.json`).

> ¿Empiezas una conversación con una IA que no conoce el proyecto? Pégale
> [`docs/contexto-chat.md`](docs/contexto-chat.md): negocio, stack, historial de
> los PR #1–#16, configuración externa, estado y reglas, todo en un archivo.

## Estructura

- `*.html` — páginas del sitio con URLs traducidas. Cuatro idiomas completos
  (ES/EN/FR/RU) más los del **programa multiidioma** en curso (IT/NL/DE/AR, ver
  su sección más abajo): hoy IT cubre 14 páginas (core + landings de ocasión +
  formulario `/prenota`), a falta del blog.
- `post/*.html` — artículos del blog (servidos como `/post/<slug>`).
- `img/` — imágenes (WebP + fallback JPG, con variantes responsivas `-640`/`-768`/`-1280`;
  no todas tienen las tres: nunca se genera una variante más ancha que el original).
- `vercel.json` — `cleanUrls`, `trailingSlash` y redirecciones 301.
- `robots.txt`, `sitemap.xml`.
- `mobile.css` — ajustes responsive (se sirve `immutable` un año: **si lo tocas,
  sube `CSS_V` en `scripts/apply-lang-switcher.py` y reejecútalo** para propagar
  el `?v=` a todas las páginas, o los visitantes recurrentes verán el HTML nuevo
  con la CSS vieja).
- `js/lang-switcher.js` — desplegable de idioma del header (móvil **y**
  escritorio). Mismo versionado, con `JS_V`.
- `scripts/check-links.sh` — comprobación anti-regresión de enlaces (ver abajo).
- `scripts/check-lang-switcher.py` — comprobación del selector de idioma (ver abajo).
- `scripts/apply-lang-switcher.py` — regenera el selector de idioma del header
  y propaga el `?v=` de `mobile.css` y `js/lang-switcher.js`.
- `scripts/check-datos-comerciales.sh` — grep anti-invención en los 8 idiomas
  (ver abajo). **Obligatorio antes de cada push a `main`.**
- `scripts/test-lead-api.js` — pruebas de `/api/lead` con Resend simulado (sin red).
- `scripts/test-booking-form.js` — pruebas del formulario de reserva de los 5
  idiomas (ES/EN/FR/RU/IT): validación de nombre/email/teléfono y selector de prefijo. Ejecuta las
  reglas tal y como se sirven en el HTML. `node scripts/test-booking-form.js`.

## ⚠️ Antes de cada push a `main` (obligatorio)

Vercel despliega automáticamente cada push a `main`. Para evitar la regresión de
los 404 del blog (los `/post/...` se han caído en producción dos veces), ejecuta
**siempre** la comprobación de enlaces antes de hacer push:

```bash
# Contra producción (estado actual en vivo):
scripts/check-links.sh

# O contra un servidor local que sirva el repo (recomendado antes de push):
python3 -m http.server 8000 &          # sirve el repo en localhost:8000
scripts/check-links.sh http://127.0.0.1:8000
```

El script hace `curl` a todas las URLs internas enlazadas desde los índices del
blog (`/blog-nautico-marbella`, `/yacht-blog`, `/blog-nautique`, `/morskoy-blog`)
y **falla con exit 1 si alguna no responde 200**. Si falla, **no hagas push**.

> Nota: un `python3 -m http.server` pelado **no** replica `cleanUrls` de Vercel,
> así que los `/post/<slug>` sin `.html` darán 404 en local aunque el archivo
> exista. Para una comprobación local de verdad, sírvelo con un handler que
> pruebe también `<ruta>.html`; con eso `check-links.sh http://127.0.0.1:<puerto>`
> pasa entero sin salir a producción:
>
> ```python
> # serve.py — cleanUrls:true + trailingSlash:false
> import http.server, os
> ROOT = os.getcwd()
> class H(http.server.SimpleHTTPRequestHandler):
>     def translate_path(self, path):
>         p = path.split('?', 1)[0].split('#', 1)[0]
>         full = os.path.join(ROOT, p.lstrip('/'))
>         if p in ('', '/'): return os.path.join(ROOT, 'index.html')
>         if os.path.isfile(full): return full
>         if os.path.isfile(full + '.html'): return full + '.html'
>         return full
> http.server.HTTPServer(('127.0.0.1', 8123), H).serve_forever()
> ```
>
> La alternativa sigue siendo la URL de *Preview* de Vercel del PR, o producción
> tras el deploy.

Y, si has tocado páginas o `hreflang`, el selector de idioma del header
(offline, sin red):

```bash
scripts/check-lang-switcher.py
```

Y **siempre** que haya contenido nuevo o editado, el grep anti-invención de
datos comerciales, que cubre los 8 idiomas del programa:

```bash
scripts/check-datos-comerciales.sh
```

## Selector de idioma del header

Los enlaces de idioma del header **no se escriben a mano**: se generan desde los
`<link rel="alternate" hreflang>` de cada página, así que cambiar de idioma te
deja en la traducción de *esa misma* página, no en la portada. Una página que no
declara alternate para un idioma no ofrece ese idioma — por eso las páginas
ES/EN/FR/RU sin versión italiana siguen mostrando solo sus cuatro aunque el
programa tenga ocho idiomas registrados, y los posts que solo existen en ES/EN muestran solo esos dos.

Al añadir una página o una traducción: pon bien sus `hreflang`, regenera con
`scripts/apply-lang-switcher.py` y valida con `scripts/check-lang-switcher.py`.
El validador falla si un enlace apunta a algo que no existe, a una página que
está en otro idioma del que dice, o si el `dir="rtl"` no cuadra con el idioma.

**Es un desplegable en todos los anchos, no solo en móvil.** Con ocho idiomas la
fila en línea ya no cabe en el header ni en escritorio, así que el patrón
*disclosure* que el PR #15 dejó solo en ≤760px pasa a ser el único:

- Un botón con el código del idioma actual y un chevron (`IT ▾`), alineado a la
  derecha justo antes del CTA de reserva. Alto 34px en escritorio y 38px en
  móvil, de modo que **no cambia el alto del header** (69px escritorio / 91px
  móvil, los mismos de antes: sin CLS y sin tocar `[data-nav-spacer]`).
- Al pulsarlo se abre un panel anclado al **borde derecho** del botón —con
  `inset-inline-end`, no `left`, para que el día que entre el árabe se ancle
  solo al lado correcto—, de 174px de ancho y con `max-height:min(70vh,420px)`
  y scroll propio, porque ocho filas no siempre caben en un móvil apaisado.
- Cada fila muestra **código + endónimo** (`IT  Italiano`), con 40px de alto en
  escritorio y 44px en móvil (WCAG 2.5.5). El idioma actual va en el verde de
  marca, con fondo `#f1f6f5` y `aria-current="true"`.
- Accesibilidad igual que antes: `aria-expanded`, `aria-controls`, foco al
  primer idioma **distinto** del actual al abrir, cierre con `Escape`, con clic
  fuera y al salir con `Tab`.
- **Sin JavaScript** no hay panel que abrir, así que los idiomas se quedan en
  línea como siempre y el botón no se pinta; en ese modo degradado solo se ven
  los códigos de dos letras (el endónimo va oculto). Ocho códigos ocupan ~236px:
  siguen cabiendo en el header.

## Idiomas del programa multiidioma (IT · NL · DE · AR)

El sitio pasa de 4 a 8 idiomas en **oleadas**: primero IT, luego NL, luego DE y
por último AR. Cada oleada se cierra entera antes de abrir la siguiente, y cada
una replica el sitio completo en **tres entregas**:

| Entrega | Contenido |
|---|---|
| 1 | Core: home, ficha de flota, hub de experiencias y las 2 landings más rentables (pedida y bodas). |
| 2 | Resto de landings de ocasión + **formulario de reserva propio del idioma**. |
| 3 | Blog completo, incluidos los 5 posts de zona. |

**Estado:** IT — Entregas 1 y 2 hechas (14 páginas: 5 core + 8 landings +
formulario `/prenota`). Falta la Entrega 3 (blog). NL, DE y AR sin empezar.

### Convención de slugs

Home corta con el código del idioma (`/it`, `/nl`, `/de`, `/ar`); el resto,
descriptivos y con la keyword principal del idioma, siguiendo el patrón del
español (`<keyword>-<barco>-marbella`), sin acentos ni diacríticos:

**Core (Entrega 1)**

| | Home | Flota | Experiencias | Pedida | Bodas |
|---|---|---|---|---|---|
| ES | `/` | `flota-barcos-marbella` | `actividades-barco-marbella` | `pedida-matrimonio-barco-marbella` | `fotos-boda-barco-marbella` |
| IT | `/it` | `flotta-barche-marbella` | `escursioni-barca-marbella` | `proposta-matrimonio-barca-marbella` | `foto-matrimonio-barca-marbella` |
| NL | `/nl` | *pendiente* | *pendiente* | *pendiente* | *pendiente* |
| DE | `/de` | *pendiente* | *pendiente* | *pendiente* | *pendiente* |
| AR | `/ar` | *pendiente* | *pendiente* | *pendiente* | *pendiente* |

**Landings de ocasión y formulario (Entrega 2)** — fijados con la oleada IT:

| Página | ES | IT |
|---|---|---|
| Despedida de soltero | `despedida-soltero-barco-marbella` | `addio-al-celibato-barca-marbella` |
| Despedida de soltera | `despedida-soltera-barco-marbella` | `addio-al-nubilato-barca-marbella` |
| Cumpleaños | `cumpleanos-en-barco-marbella` | `compleanno-in-barca-marbella` |
| Sunset tour | `sunset-tour-barco-marbella` | `sunset-tour-barca-marbella` |
| Delfines | `avistamiento-delfines-marbella` | `avvistamento-delfini-marbella` |
| Gibraltar | `ruta-barco-gibraltar-marbella` | `escursione-barca-gibilterra-marbella` |
| Eventos de empresa | `eventos-empresa-barco-marbella` | `eventi-aziendali-barca-marbella` |
| Comparativa | `barco-privado-vs-plataformas` | `barca-privata-vs-piattaforme` |
| **Formulario de reserva** | `reservar` | `prenota` |

Los slugs de NL/DE/AR se fijan aquí al abrir su oleada, antes de escribir una
sola página, para que no haya dos convenciones conviviendo.

### Formato de cifras y potencia

| Idioma | Precio | Potencia |
|---|---|---|
| ES | `1.200€` | `600 CV` |
| EN | `€1,200` | `600 hp` |
| FR / RU | `1 200 €` | `600 ch` / `600 л.с.` |
| **IT** | `1.200 €` | `600 CV` |
| **NL** | `€ 1.200` | `600 pk` |
| **DE** | `1.200 €` | `600 PS` |
| **AR** | *se fija al abrir su oleada* | *idem* |

### Redacciones canónicas de los idiomas nuevos

**Fuente única.** Cualquier página IT/NL/DE debe usar estas cadenas literalmente
(adaptando concordancia, no el contenido). Están escritas a partir de los datos
confirmados, no traducidas palabra por palabra: el objetivo es que suenen a
alguien que vende en ese idioma, no a un traductor automático.

**Lo incluido** *(catering ligero + agua y refrescos + botella de champán de
cortesía)* — **actualizado el 19/08/2026: sustituye a la copa confirmada ese
mismo día.**

- **IT** — `catering leggero, acqua e bibite e una bottiglia di champagne in omaggio`
  · enumeración completa: `skipper, carburante della rotta abituale, assicurazione,
  paddle surf, snorkeling, catering leggero, acqua e bibite, una bottiglia di champagne
  in omaggio e IVA`.
- **NL** — `lichte catering, water en frisdrank en een fles champagne van het huis`
  · enumeración completa: `schipper, brandstof voor de gebruikelijke route,
  verzekering, suppen, snorkelen, lichte catering, water en frisdrank, een fles
  champagne van het huis en btw`.
- **DE** — `leichtes Catering, Wasser und Softdrinks sowie eine Flasche Champagner
  als Aufmerksamkeit des Hauses` · enumeración completa: `Skipper, Kraftstoff für die
  übliche Route, Versicherung, Stand-up-Paddling, Schnorcheln, leichtes Catering,
  Wasser und Softdrinks, eine Flasche Champagner als Aufmerksamkeit des Hauses und
  Mehrwertsteuer`.

*«In omaggio» / «van het huis» / «als Aufmerksamkeit des Hauses» son las tres
formas idiomáticas de «de cortesía»: dicen que la botella la pone la casa. **Una
botella por reserva, incluida en la tarifa y en todas las duraciones**; no se
promete marca, tamaño ni un número mayor de botellas. Las botellas **adicionales**
siguen siendo extra de pago, y así hay que llamarlas para que no choquen con la
incluida.*

**Equipo de sonido** *(confirmado el 19/08/2026; corrige la confirmación anterior,
que lo daba por inexistente)*

- **NL** — `geluidssysteem met Bluetooth: verbind je eigen muziek`
- **DE** — `Soundsystem mit Bluetooth: eigene Musik verbinden`

*El cliente conecta su propia música. **Prohibido** prometer DJ, barra, altavoces
portátiles adicionales, karaoke, ni marca o potencia del equipo — y nada de
«premium sound» ni superlativos: el dato, limpio.*

**Puerto base y salida desde otros puertos**

- **IT** — `Porto base: Puerto Banús. Partenza da [X] disponibile su richiesta.`
- **NL** — `Thuishaven: Puerto Banús. Vertrek vanuit [X] op aanvraag mogelijk.`
- **DE** — `Heimathafen: Puerto Banús. Abfahrt ab [X] auf Anfrage möglich.`

*Igual que en ES/EN/FR/RU: **prohibido** inventar suplementos, precios de
recogida, tiempos de traslado del barco o condiciones. Solo «su richiesta / op
aanvraag / auf Anfrage», y nunca ofrecer la salida desde X como estándar.*

**Capacidad**

- **IT** — `fino a 10 persone a bordo` · tarifa: `la tariffa è per la barca
  intera, non a persona`.
- **NL** — `tot 10 personen aan boord` · tarifa: `het tarief geldt voor de hele
  boot, niet per persoon`.
- **DE** — `bis zu 10 Personen an Bord` · tarifa: `der Preis gilt für das ganze
  Boot, nicht pro Person`.

**Motorización**

- **IT** — `2× Mercury V12 da 600 CV (1.200 CV totali)`
- **NL** — `2× Mercury V12 van 600 pk (1.200 pk in totaal)`
- **DE** — `2× Mercury V12 mit je 600 PS (1.200 PS gesamt)`

**Patrón multilingüe.** El patrón habla **ES · EN · FR · RU**. Las páginas de los
idiomas nuevos lo dicen tal cual y **no** afirman que el patrón hable italiano,
neerlandés, alemán ni árabe a bordo.

**Atención en italiano (confirmado por el propietario el 19/08/2026).** Se
atiende por **WhatsApp y email en italiano**. Es publicable en las páginas IT
—y solo en ellas— con esta redacción canónica:

- **IT** — `Assistenza in italiano su WhatsApp ed e-mail`
  · variante larga: `rispondiamo in italiano su WhatsApp e per e-mail`.

*Cubre solo el canal escrito antes y hasta el día de la salida.* **Prohibido**
derivar de aquí que el patrón hable italiano a bordo, que haya alguien
italoparlante en el barco o que la atención sea 24/7. Donde conviven las dos
cosas —la comparativa `barca-privata-vs-piattaforme`— se dicen por separado y en
ese orden: el patrón habla ES/EN/FR/RU, la asistencia escrita es en italiano.
Para NL, DE y AR el dato **sigue sin confirmar**: no se publica.

### Páginas legales

**No se traducen a los idiomas nuevos.** Aviso legal, privacidad, términos y
cookies existen solo en ES/EN/FR/RU (16 páginas). El footer de las páginas
IT/NL/DE/AR enlaza a las **EN** (`/legal-notice`, `/privacy-policy`,
`/terms-conditions`, `/cookies-policy`), con `hreflang="en"` en cada enlace y un
`(in inglese)` visible al lado para que nadie llegue por sorpresa a una página
en otro idioma. Decisión del propietario.

### Formularios de reserva

Cada idioma nuevo tiene **su propio formulario**, creado en la **Entrega 2** de
su oleada. Hasta entonces, los CTA de la Entrega 1 apuntan al formulario **EN**
(`/booking`): es lo más cercano que un lector italiano, neerlandés o alemán
entiende sin fricción, y evita publicar enlaces muertos o mandarlo al español.

**IT ya está recableado:** los **27** CTA de las 5 páginas de la Entrega 1
apuntan a `/prenota`. El grep para la oleada siguiente, con sus páginas:

```bash
grep -o 'href="/booking"' <páginas de la Entrega 1 del idioma> | wc -l
```

> Ojo con `grep -c`: cuenta **líneas**, no ocurrencias. En italiano coincidían
> (27 y 27), pero no tiene por qué ser así.

El formulario nuevo **no se escribe desde cero**: se transforma el inglés con
sustituciones literales afirmadas una a una, de modo que herede exactamente la
misma lógica ya probada (validación, prefijos, orden de disparo, `/api/lead`,
no-fuga a GA4). Después hay que **dar de alta la página en
`scripts/test-booking-form.js`** (array `PAGES`: fichero, `lang`, prefijo por
defecto, ISO, nombre de Alemania y texto del buscador de países) y ejecutarlo:
con el italiano son **380 comprobaciones** sobre 5 formularios.

La lista de prefijos se traduce **y se reordena** alfabéticamente en el idioma
de la página: el test lo comprueba con `localeCompare(nombre, lang)`.

`js/form-tracking.js` no necesita cambios: saca el parámetro `lang` de
`<html lang>`, así que el embudo de GA4 ya separa IT del resto por sí solo.

### Árabe: última oleada, y con trabajo propio

**AR es la última y no se empieza hasta cerrar DE.** No es «un idioma más»:
requiere `dir="rtl"` en `<html>`, espejado de nav, footer, breadcrumbs y grids,
revisión de tipografía y de los iconos direccionales, y una pasada de QA visual
completa. Nada de eso está hecho, y hacerlo a medias se ve peor que no tenerlo.

Lo único ya preparado es la infraestructura del selector: `ORDER`, `CODE`,
`ENDONYM`, `HOME`, `BTN_LABEL` y el conjunto `RTL` de
`scripts/apply-lang-switcher.py` ya incluyen `ar`, el generador emite `dir="rtl"`
en el enlace al árabe desde cualquier página LTR, `check-lang-switcher.py` valida
que ese `dir` esté donde toca y solo ahí, y el panel del selector se posiciona
con `inset-inline-end` en vez de `left`, así que se ancla solo al lado correcto.

## Despliegue

`git push origin main` → Vercel despliega. Tras el deploy, verifica en producción:

```bash
scripts/check-links.sh                 # 0 fallos esperados
curl -sI https://www.rentboatmarbella.com/robots.txt | head -1
```

## Reglas para futuras sesiones

### Regla anti-invención de datos comerciales

**Cualquier dato comercial en contenido nuevo (precios, duraciones, capacidades, extras, qué incluye una tarifa) debe existir previamente en la home o el formulario de reserva. Si no existe, marcarlo como `[CONFIRMAR CON PROPIETARIO]` y no publicar hasta confirmación. Nunca completar con cifras plausibles inventadas.**

Referencia de datos confirmados a día de hoy (fuente: home + formulario `/reservar`):

- **Duraciones y tarifas:** 2 h → 1.200 € · 4 h → 1.800 € · 8 h (día completo) → 3.000 €. *(No existe tarifa de 6 h ni de 2.400 €.)*
- **Capacidad:** hasta **10** personas (por barco, no por persona).
- **Barco y motorización:** De Antonio D50, 15 m de eslora, año 2026, **2× Mercury V12 de 600 CV (total 1.200 CV)**. Formato por idioma: ES `2× Mercury V12 600 CV` · EN `2× Mercury V12 600 hp` · FR `2× Mercury V12 600 ch` · RU `2× Mercury V12 600 л.с.` · IT `2× Mercury V12 da 600 CV` (NL/DE/AR: ver «Idiomas del programa multiidioma»)
- **Incluido:** patrón, combustible de la ruta habitual, seguro, paddle surf, snorkel, **catering ligero** (fruta y frutos secos), **agua y refrescos**, **una botella de champán de cortesía** e IVA. *(Confirmado por el propietario el 19/08/2026; la botella **sustituye a la copa** que el propietario había confirmado ese mismo día. Una botella por reserva, incluida en la tarifa y en todas las duraciones: no se promete marca, tamaño ni más de una.)* Redacción por idioma: ES `catering ligero, agua y refrescos, y botella de champán de cortesía` · EN `light catering, water and soft drinks, and a complimentary bottle of champagne` · FR `catering léger, eau et sodas, et une bouteille de champagne offerte` · RU `лёгкий кейтеринг, вода и напитки, и бутылка шампанского в подарок` · IT `catering leggero, acqua e bibite e una bottiglia di champagne in omaggio` (NL/DE/AR: ver «Idiomas del programa multiidioma»).
- **Equipo de sonido: SÍ existe** *(aclarado por el propietario el 19/08/2026; **corrige** la confirmación anterior del mismo día, que lo daba por inexistente. La retirada de todas las menciones fue decisión editorial, no de existencia)*. Hay **equipo de sonido con Bluetooth** y el cliente **conecta su propia música**. Redacción canónica —**fuente única, y la única forma en que puede publicarse**—: ES `equipo de sonido con Bluetooth: conecta tu propia música` · EN `sound system with Bluetooth: connect your own music` · FR `système audio avec Bluetooth : connectez votre propre musique` · RU `аудиосистема с Bluetooth: подключайте свою музыку` · IT `impianto audio con Bluetooth: collega la tua musica` · NL `geluidssysteem met Bluetooth: verbind je eigen muziek` · DE `Soundsystem mit Bluetooth: eigene Musik verbinden`. **Límites:** no se promete **DJ**, **barra**, **altavoces portátiles adicionales**, **karaoke**, ni **marca o potencia** del equipo; nada de «premium sound» ni superlativos. **Dónde se publica** (criterio editorial, no técnico): sí en las landings de fiesta —despedidas, cumpleaños, eventos de empresa— y en los posts de boat party, como ítem de equipamiento y **nunca como titular**; sí en la sección de equipamiento de las fichas de flota, junto a paddle surf y snorkel; **no** en pedida, bodas, fotos de boda, sunset, delfines ni Gibraltar, cuyo tono es otro, salvo que la página ya tenga un bloque de equipamiento completo donde su ausencia chirríe.
- **NO existe a bordo** (confirmado 19/08/2026, no publicar): nevera, ducha de agua dulce, **colchoneta flotante** *(el único equipo de agua es el paddle surf)*. **No hay política de descorche**: no se promete subir bebida propia. **Alcohol incluido: solo la botella de champán de cortesía**; el resto de bebidas incluidas son sin alcohol. Las botellas **adicionales** siguen siendo extra de pago y hay que nombrarlas así («adicional / additional / supplémentaire / дополнительная / aggiuntiva») para que no choquen con la incluida. Los **globos** solo existen dentro del extra «decoración especial (+120 €)», nunca como incluido.
- **El sunset no lleva catering especial:** mismo catering ligero + agua y refrescos + botella de champán de cortesía que el resto de salidas (confirmado 19/08/2026).
- **Puerto base y salidas desde otros puertos** *(confirmado por el propietario el 19/08/2026)*: el barco está amarrado en **Puerto Banús (Marbella)**. La **salida desde otros puertos de la Costa del Sol** (Estepona, Sotogrande, Fuengirola, Benalmádena, Málaga…) está **disponible a consultar**. Redacción canónica por idioma: ES `Puerto base: Puerto Banús. Salida desde [X] disponible a consultar.` · EN `Home port: Puerto Banús. Departure from [X] available on request.` · FR `Port d'attache : Puerto Banús. Départ depuis [X] possible sur demande.` · RU `Порт базирования: Пуэрто-Банус. Выход из [X] — по запросу.` · IT `Porto base: Puerto Banús. Partenza da [X] disponibile su richiesta.` **Prohibido** inventar suplementos, precios de recogida, tiempos de traslado del barco o condiciones: solo «a consultar / on request», y nunca prometer la salida desde X como estándar.
- **Atención en italiano** *(confirmado por el propietario el 19/08/2026)*: se atiende por **WhatsApp y email en italiano**. Publicable **solo en las páginas IT** con la redacción canónica `Assistenza in italiano su WhatsApp ed e-mail`. Cubre el canal escrito, no el patrón: **prohibido** afirmar que se hable italiano a bordo. Sin confirmar para NL, DE y AR.
- Formato de cifras por idioma: ES `1.200€` · EN `€1,200` · FR/RU `1 200 €` · IT `1.200 €` · NL `€ 1.200` · DE `1.200 €`.
- **Comprobación automática:** `scripts/check-datos-comerciales.sh` hace dos cosas y falla con cualquiera de ellas. **(a)** Busca los **claims prohibidos** (nevera, hielo, descorche, ducha de agua dulce, colchoneta, alcohol incluido, tarifa de 6 h, la **redacción vieja de la «copa» de champán**, y el equipo que la casa **no** pone: DJ, barra premium, altavoz portátil, karaoke) en los 8 idiomas, fuera de comentarios HTML. **(b)** Comprueba que el **claim confirmado** del equipo de sonido no derive: toda mención del equipo tiene que llevar «Bluetooth», que es la palabra que comparten las siete redacciones canónicas. Una mención sin ella es una reescritura a mano y rompe el build. Al abrir una oleada nueva hay que añadirle sus patrones.
