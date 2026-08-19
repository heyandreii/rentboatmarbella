# Estado del proyecto — rentboatmarbella.com

**Documento vivo.** Última actualización: **19 de agosto de 2026** (14.ª tanda del día).
Objetivo: que cualquier sesión futura (o el propietario) entienda en 5 minutos qué
es esto, qué está hecho, qué falta y qué reglas no se pueden romper.

Documentos relacionados: [`README.md`](README.md) (cómo trabajar en el repo y
reglas duras), [`SEO-CHANGELOG.md`](SEO-CHANGELOG.md) (detalle técnico de cada
tanda de trabajo), [`docs/GA4-embudo-reserva.md`](docs/GA4-embudo-reserva.md)
(cómo leer la analítica) y [`docs/contexto-chat.md`](docs/contexto-chat.md)
(contexto completo para pegar al abrir una conversación con una IA que no conoce
el proyecto).

---

## 1. Resumen

Web de **chárter privado de un solo barco** —un De Antonio D50 de 15 m, año 2026,
amarrado en **Puerto Banús (Marbella)**— con reserva directa, sin marketplace de
por medio. Cuatro idiomas completos con URLs traducidas (**ES / EN / FR / RU**) y
un **programa multiidioma** en curso que lo lleva a ocho: **IT → NL → DE → AR**,
en oleadas de tres entregas cada una. **El italiano y el neerlandés están
completos**: 29 páginas cada uno —core, landings de ocasión, formulario propio,
índice de blog y 14 posts— y son el quinto y el sexto idioma del sitio a todos
los efectos. **La oleada siguiente es DE.**

**Stack:** HTML estático puro, sin framework ni paso de build. Desplegado en
**Vercel** desde `main` (`cleanUrls: true`, `trailingSlash: false`); cada push a
`main` despliega. Una única función serverless (`api/lead.js`) que envía el aviso
de cada solicitud por **Resend**. Medición con **GA4**, consentimiento con
**Cookiebot**.

**Tamaño actual:** 188 URLs en el sitemap · **84 posts de blog** · **6 índices de
blog** · **6 formularios de reserva** (uno por idioma publicado) · 666 bloques
JSON-LD validados.

**Estado general:** el sitio está **completo y en producción**. Las tandas de julio
y agosto de 2026 (PR #1 a #15) cerraron los problemas críticos (404 del blog,
accesibilidad, schema, formulario que perdía los datos de contacto). Lo que queda
es afinado, contenido y decisiones comerciales — nada bloqueante.

---

## 2. Hecho

### Base y contenido (julio 2026 — Fases 1 a 6 del plan SEO)

- **Blog reparado.** Los `/post/...` enlazados desde los índices no existían: 404
  en todo el blog. Creados los posts y, desde entonces, un script anti-regresión
  impide que vuelva a pasar. Hoy: **56 posts** en 4 idiomas, todos enlazados desde
  el índice de su idioma.
- **Schema completo** en las 110 páginas: `LocalBusiness` (con `legalName` y
  `taxID` reales), `Product` + `Offer`, `FAQPage`, `BlogPosting`,
  `BreadcrumbList`, y `Organization` + `WebSite` en las 4 homes. 372 bloques
  JSON-LD validados offline contra el vocabulario oficial de schema.org: 0 errores.
- **Accesibilidad WCAG AA** (PR #2, #3): labels, `aria`, `main`, contraste del
  naranja de marca corregido a navy/ámbar. Lighthouse móvil: accesibilidad **96**,
  buenas prácticas 100, SEO 100. El contraste del footer, que era el fallo que
  quedaba, se corrigió en agosto de 2026 (ver más abajo).
- **Rendimiento:** 17 imágenes JPG → WebP (**20 MB → 1,7 MB, −92 %**), `<picture>`
  con fallback, `fetchpriority` en el LCP y `loading="lazy"` en el resto. PageSpeed
  88–99.
- **i18n:** `hreflang` recíproco ES/EN/FR/RU + `x-default` en todos los grupos de
  páginas traducidas; nav, footer y breadcrumb siempre en el idioma de la página.
- **Legal:** Aviso Legal, Privacidad, Términos y Cookies en los 4 idiomas (16
  páginas) con datos fiscales reales.
- **`sitemap.xml`** con 130 URLs, sin rotas, referenciado desde `robots.txt`.
- **`robots.txt` abierto a bots de IA**: `GPTBot`, `ClaudeBot`, `PerplexityBot` y
  `Google-Extended` permitidos explícitamente.

### Reserva (PR #1, #12, #13, #14)

El recorrido de reserva pasó de ser un formulario decorativo a un embudo real:

- **PR #1** — formulario funcional en los 4 idiomas con mensaje de WhatsApp
  prerrellenado (duración, invitados, fecha, extras, total).
- **PR #12** — se descubrió que **nombre, email, teléfono y peticiones no iban a
  ningún sitio**: eran `<input>` sin `id`, y el cliente los rellenaba para nada.
  Ahora sí viajan en el mensaje de WhatsApp. Corregida también la fecha por
  defecto, que estaba hardcodeada en el pasado.
- **PR #13** — `/api/lead`: cada solicitud llega además por **email a `info@`** vía
  Resend, para no perder a quien reserva desde un ordenador sin WhatsApp Web.
  Fire-and-forget: si la API falla, WhatsApp se abre igual.
- **PR #14** — nombre, email y teléfono **obligatorios y validados** (ya no se
  puede enviar «test»), y **selector de prefijo internacional** de 54 países sin
  librerías ni imágenes (+3,8 KB gzip, cero peticiones nuevas).

### Medición (PR #12)

Embudo de reserva en GA4 (`form_start` → `form_progress` → `whatsapp_submit` /
`form_abandon`) con parámetros de producto: duración, invitados, nº de extras,
días hasta la salida, idioma y ubicación del formulario. **Anónimo por diseño:** el
código de medición nunca lee el `.value` de los campos de identidad; se verificó
con cadenas canario que nada de eso sale hacia Google. Guía de consulta en
[`docs/GA4-embudo-reserva.md`](docs/GA4-embudo-reserva.md).

### Correcciones de datos (PR #7, #10, #11)

- Eliminada la **tarifa de 6 h**, que no existe.
- **Capacidad 10** (no 12) en todas las páginas.
- **Ficha técnica del barco**: la tarjeta de motores mostraba `2× M` truncado en
  los 4 idiomas → **2× Mercury V12 600 CV (1.200 CV totales)**, también en el
  `Product` vía `additionalProperty`.
- **Search Console**: los `Offer` de las 4 landings corporativas tenían moneda sin
  importe. Corregido con precio visible en la página **y** en el schema (1.200 €
  como suelo, no como tarifa cerrada).
- Eliminado el cuadro «FB» del footer, que era texto sin enlace.

### Otros (PR #15)

Header móvil: en ≤760px los 4 idiomas se pliegan en un desplegable, y cada enlace
lleva a la traducción de **esa misma página** (se genera desde los `hreflang`, no
a mano).

### Boat party: CTR y versión ES (agosto 2026)

- **Title y meta description del post EN de boat party reescritos para CTR.** Estaba
  en posición ~9-10 para «boat party puerto banus» con **0 clics en 58 impresiones**:
  el problema era el gancho, no el ranking. Ahora el title lleva beneficio y cifra
  real (barco privado para 10, desde 1.200 €) y la description enumera qué incluye.
  Sincronizados `og:`, `twitter:` y el `headline` del `BlogPosting`, que iban por
  libre con tres textos distintos.
- **Creado `post/fiesta-en-barco-puerto-banus`**, versión ES localizada (no traducida):
  gancho y ejemplos adaptados a despedidas, cumpleaños y grupos de amigos. Con
  `hreflang` recíproco EN↔ES + `x-default`, card en el índice ES, dos enlaces
  contextuales entrantes y entrada en el sitemap.
- **Corregido `scripts/apply-lang-switcher.py`.** Su regex solo reconocía el selector
  *anterior* al PR #15, así que en un repo ya migrado no encontraba ninguno y fallaba
  con «0 selectores encontrados» en las 101 páginas: era imposible regenerar el
  selector al añadir una traducción, que es justo para lo que existe. Ahora acepta las
  dos formas y es idempotente.

### Contraste del footer (agosto 2026)

- **Títulos de sección del footer de `#3F7A72` a `#e6ecee` en las 101 páginas.**
  «EXPERIENCIAS», «INFO», «CONTACTO» y sus equivalentes EN/FR/RU iban en el verde
  de marca sobre el fondo `#12232B`: **3,26:1**, por debajo del 4,5:1 que WCAG AA
  exige a texto pequeño (11px, `font-weight:700`). Era el último fallo de
  accesibilidad que reportaba PageSpeed (96 en móvil y escritorio). Ahora
  **13,53:1**.
- `#e6ecee` no es un color nuevo: ya es el color base declarado en el contenedor
  del footer (`background:#12232B;color:#e6ecee`) y del que derivan sus enlaces
  (`rgba(230,236,238,.7)`, 7,29:1). Los títulos pasan a ese mismo color a plena
  opacidad.
- El estilo es **inline en cada página**, no vive en `mobile.css`, así que no hubo
  ningún `?v=` que subir. Cambio hecho por script (sustitución literal de la cadena
  de estilo completa, 303 ocurrencias = 101 páginas × 3 títulos) y verificado línea
  a línea: 303 inserciones / 303 borrados, 0 líneas donde cambiara algo más que el
  color, y los otros 1.008 usos de `#3F7A72` del sitio intactos.

### Traducciones: los 4 grupos que faltaban (agosto 2026)

Nueve posts nuevos en dos tandas. Con esto **no queda ningún post monolingüe** y los
cuatro grupos del backlog están completos en ES/EN/FR/RU:

- **Licencia** — `faut-il-permis-bateau-marbella` (FR) y
  `nuzhny-li-prava-arenda-yakhty-marbella` (RU).
- **Bodas y eventos** — `weddings-events-boat-marbella` (EN),
  `mariages-evenements-bateau-marbella` (FR) y
  `svadby-meropriyatiya-na-yakhte-marbella` (RU). Era el último post monolingüe.
- **Costa del Sol** — `location-bateau-costa-del-sol-puerto-banus` (FR) y
  `arenda-yakhty-kosta-del-sol-puerto-banus` (RU).
- **Boat party** — `soiree-bateau-puerto-banus` (FR) y
  `vecherinka-na-yakhte-puerto-banus` (RU).

Localización, no traducción literal: el post de licencia FR compara con el *permis
plaisance* francés y el RU con los *права ГИМС*, en ambos casos con una respuesta
honesta sobre el reconocimiento de títulos extranjeros (no se afirma nada que no
esté verificado); los de bodas hablan a quien viene de fuera a casarse en la Costa
del Sol; los de Costa del Sol usan el tiempo desde el aeropuerto de Málaga como
argumento para quien vuela desde París o Moscú.

**Deuda detectada al traducir:** el original ES de bodas afirma descorche gratuito,
sonido Bluetooth, champagne y «agua y hielo incluidos», y los posts de precios FR y
RU repiten lo del descorche y el agua y el hielo. Nada de eso se ha trasladado a las
traducciones nuevas — ver el punto 8 del backlog (§3).

### Deuda de datos sin confirmar, pagada (19 de agosto de 2026)

El propietario respondió a las preguntas abiertas y se corrigió **todo el sitio de
una vez**, no solo las páginas que las traducciones habían ido destapando:

- **Fuera:** equipo de sonido / Bluetooth (14 páginas) *(revertido más tarde ese
  mismo día: el equipo sí existe, ver «Equipo de sonido: de claim prohibido a claim
  confirmado»)*, política de descorche (14),
  «agua y hielo» como claim (11), nevera y ducha de agua dulce (6), y los globos
  prometidos sueltos, que ahora solo aparecen dentro del extra de decoración (+120 €).
- **Dato nuevo incluido:** una **copa de champán de cortesía**, añadida a las
  enumeraciones canónicas —respuesta «¿Qué incluye el precio?» y tarjeta de catering
  de las 4 homes, párrafo y tarjeta de tarifa de las 4 fichas de flota, FAQ del
  sunset— editando `FAQPage` y HTML visible a la vez para que no se desincronicen.
  *(La copa quedó superada ese mismo día: el propietario la subió a **botella**. Ver
  «Champán: de copa a botella» más abajo.)*
- **Las 4 landings de sunset corregidas:** fuera la tabla de quesos y embutidos y la
  botella para brindar; el sunset lleva el mismo catering que el resto de salidas.
  Era lo único del sitio que prometía algo que podía no entregarse.
- Las botellas de champán **como extra de pago siguen siendo correctas** y se han
  dejado: copa incluida, botella extra. *(Con el cambio a botella incluida del mismo
  día, esas menciones pasan a llamarse «botella adicional».)*

Retirados los 6 comentarios `[CONFIRMAR CON PROPIETARIO]` de los posts nuevos.

### Imágenes responsivas: `sizes` reales y tier -768 (19 de agosto de 2026)

Dos tandas seguidas sobre el mismo problema. PageSpeed móvil daba 89 con LCP 3,0 s
y 269 KiB de imágenes sobredimensionadas. Las `<picture>` y los `srcset` ya
existían y eran correctos: **lo que fallaba era el atributo `sizes`**, que
declaraba huecos sin relación con los reales, así que el navegador elegía siempre
la variante más pesada.

- **Primero, hero y cabina.** El hero declaraba `100vw` (pedía 1350 px para un
  hueco de 1120) y la cabina `50vw` (675 para 536). Corregidos en las 4 homes y
  las 4 páginas de flota.
- **Después, todo el resto.** 178 de las 186 `<picture>` declaraban el mismo
  `(max-width: 768px) 100vw, 50vw` copiado. Los huecos reales se **midieron**,
  no se estimaron: sirviendo el repo en local y recorriendo las 110 páginas con
  Playwright a 360/390/412/430/760/761/1024/1280/1350 px, leyendo el
  `getBoundingClientRect()` de cada `<img>`. Las 186 caen en **8 plantillas de
  layout** (cards de actividades y blog, landings, heros de post, galería de
  flota, formularios de reserva, card destacada, hero y cabina de home), así que
  se escribió **un `sizes` por plantilla**, no 186 a mano. Siguen el hueco real
  con error <1 % en casi todo el rango.
- **Tier -768 (15 variantes).** Entre 640 y 1280 no había nada y el hueco móvil a
  DPR 2 pide ~700 px, así que los móviles DPR 2-3 —la mayoría del tráfico real—
  bajaban la -1280. Método idéntico al de las variantes existentes
  (`cwebp -q Q -resize W 0` sobre el original), con la Q y la fuente **calibradas
  por imagen** buscando la que reproduce el peso de su variante ya existente:
  todas dentro de ±1,4 % (q 79–82). Ningún original recomprimido ni sustituido.
- **`boda` y `pedida`** iban con `<source srcset="img/boda.webp">`, sin descriptor
  `w` ni `sizes` y sin ninguna variante: `boda` descargaba ~7× los píxeles que
  pintaba. Ahora tienen -640 y -768. No se generan -1280 (originales de 950 y
  900 px): sería reescalar hacia arriba, criterio ya aplicado en `flota-proa` y
  `flota-cabina`.
- **3 descriptores `w` mentían:** `despedida-soltera.webp` y `eventos.webp`
  declaraban 1600w midiendo 1448, y `flota-perfil.webp` 1600w midiendo 1920. Los
  59 ficheros referenciados declaran ya su ancho real.

**Resultado**, sumando todas las `<picture>` del sitio en un móvil de 390 px:

| | antes | ahora | |
|---|---|---|---|
| DPR 2 (usuario real) | 9.692 KiB | **5.634 KiB** | **−42 %** |
| DPR 1,75 (emulación de Lighthouse) | 8.974 KiB | **3.926 KiB** | **−56 %** |

Por página (DPR 1,75): `/actividades` 721→289 KiB · `/blog-nautico` 456→179 ·
`/fleet` 441→192 · un post 116→42 · `/reservar` 46→20.

`fetchpriority="high"` intacto en los heros y ninguno pasó a lazy: solo cambia la
**talla** elegida, nunca la prioridad ni el diseño.

### Posts de zona: 20 páginas nuevas en 4 idiomas (19 de agosto de 2026)

Cinco zonas de la Costa del Sol —**Estepona, Sotogrande, Fuengirola, Benalmádena y
Málaga**— en ES/EN/FR/RU, en dos entregas. Es la primera vez que el sitio ataca
búsquedas de zona («alquiler de barco en X»), que hasta ahora solo cubría la guía
genérica de Costa del Sol.

**Enfoque honesto, no doorway page.** El riesgo evidente de una tanda así es
publicar cinco clones con el topónimo cambiado, o insinuar que salimos de cinco
puertos distintos. Ninguna de las dos cosas:

- **Dato comercial nuevo, confirmado el 19/08/2026** y añadido a los datos
  confirmados (§6): puerto base **Puerto Banús**; salida desde otros puertos
  **a consultar**. Cada uno de los 20 posts lleva una sección «¿Cómo funciona la
  salida?» con la redacción canónica de su idioma y nada más — **no se inventan
  suplementos, precios de recogida, tiempos de traslado ni condiciones**, y en
  ningún sitio se ofrece la salida desde X como estándar. El title captura la
  búsqueda de zona sin afirmar salida desde allí; la meta description nombra el
  puerto base *y* la opción a consultar.
- **Un ángulo propio por zona**, no un molde: Estepona, la distancia real (22 km,
  20-25 min) y que las calas de poniente le quedan al lector *de camino a casa*;
  Sotogrande, que ya tiene puerto y por tanto el argumento es *quién está detrás
  del barco* —chárter directo frente a plataforma de anuncios—; Fuengirola, la
  alternativa privada a los barcos compartidos del paseo **y** el levante, que
  convierte un puerto base céntrico en una ventaja náutica y no solo logística;
  Benalmádena, qué cambia realmente a bordo frente a la excursión de Puerto
  Marina (quién decide la ruta, fondeo, reloj propio, diez y no cuarenta);
  Málaga, la aritmética del día completo para quien llega por aeropuerto o AVE.
  Cada versión está **localizada, no traducida**: la FR y la RU de Sotogrande
  reconocen el perfil residente/segunda residencia de esas comunidades, y la de
  Málaga cambia las referencias de viaje según el mercado.
- **Distancias y tiempos verificados** contra datos de mapa, no estimados: 22 km /
  20-25 min (Estepona), ~50 km / 40 min (Sotogrande), ~40 km / 30 min
  (Fuengirola), ~50 km / 35 min (Benalmádena), ~65 km / 45-60 min (Málaga).

**Estructura**, idéntica en los 20: slug según la convención de cada idioma,
header/footer/breadcrumb/nav en su idioma, el mismo patrón de 4 bloques JSON-LD
(`BlogPosting` + `BreadcrumbList` + `FAQPage` + `LocalBusiness`) con `inLanguage`
correcto y breadcrumb terminando en el canonical, `hreflang` recíproco de los 4
idiomas + `x-default` al ES en los 5 grupos, card en el índice del blog de su
idioma, un bloque «Guías por zona» entrante desde el post de Costa del Sol de su
idioma y **un solo** enlace entre zonas vecinas (no una malla).

**Deuda ajena corregida de paso.** El grep anti-invención de la Entrega 1 destapó
**cinco páginas ya publicadas** que la limpieza de datos del 19/08 no había
alcanzado: «agua y hielo» como incluido (bodas ES, licencia ES y EN), champagne
frío «listo para descorchar» (pedida ES) y una FAQ RU de despedida de soltero que
ofrecía subir bebida propia y tenerla enfriada — no hay nevera ni política de
descorche. Las cinco reescritas con las enumeraciones canónicas. El grep queda a
**0 hits fuera de comentarios** en las 130 páginas.


### Programa multiidioma: Fase 0 + Oleada IT, Entrega 1 (19 de agosto de 2026)

El sitio pasa de 4 a 8 idiomas (IT, NL, DE y AR) en oleadas, cada una completa
antes de abrir la siguiente y dividida en tres entregas: core, landings +
formulario propio, blog. Esta tanda cierra la infraestructura común y el core
italiano. Reglas, convenciones y **redacciones canónicas IT/NL/DE** viven en
`README.md` → «Idiomas del programa multiidioma».

**Fase 0 — infraestructura.** El selector de idioma pasa a **desplegable en
todos los anchos, no solo en móvil**: con ocho idiomas la fila en línea ya no
cabe en el header ni en escritorio. Botón con el código actual + panel anclado
al borde derecho con `inset-inline-end` (no `left`), filas de código + endónimo
(`IT  Italiano`), 40px de alto en escritorio y 44px en móvil, `max-height` con
scroll propio. **El alto del header no cambia** —69px en escritorio, 91px en
móvil— así que no hay CLS ni hubo que tocar `[data-nav-spacer]`. Sin JavaScript
los idiomas siguen en línea, como siempre. `mobile.css` y `js/lang-switcher.js`
cambiaron, así que subió el `?v=` en las 135 páginas (`?v=3` y `?v=2`); la
versión ahora se declara **una sola vez**, en `CSS_V`/`JS_V` de
`apply-lang-switcher.py`, en vez de repetirse a mano por página.

`apply-lang-switcher.py` y `check-lang-switcher.py` conocen ya los 8 idiomas y
el árabe como RTL: el generador emite `dir="rtl"` en el enlace al árabe desde
cualquier página LTR y el validador falla si ese `dir` está donde no toca. **Las
130 páginas ES/EN/FR/RU siguen mostrando solo los idiomas que cada una declara**
en sus `hreflang`: el techo son 8, lo ofrecido depende de la página.

**Oleada IT — Entrega 1.** Cinco páginas nuevas, localizadas desde el español,
no traducidas: `/it`, `/flotta-barche-marbella`, `/escursioni-barca-marbella`,
`/proposta-matrimonio-barca-marbella` y `/foto-matrimonio-barca-marbella`.

El gancho italiano no es el mismo que el español. El lector que llega de Italia
tiene en la cabeza **el gommone a noleggio por horas —con o sin patente— o el
posto en una gita collettiva**, así que la home explica la diferencia en esos
términos: la barca entera para tu grupo, skipper siempre a bordo (ninguna
patente, tampoco la italiana), tarifa por embarcación y no a testa. La landing
de propuesta usa que nadie os reconoce y nadie graba desde una tumbona; la de
fotos, que un servizio fotografico que en Italia pediría permisos y una playa
disputada en agosto aquí son dos horas y un solo desplazamiento.

- **Grupos `hreflang`: 5 de 4 a 5 miembros**, con todos los miembros reescritos
  (home, flota, actividades, pedida y bodas: 20 páginas existentes + las 5
  nuevas). `x-default` sigue apuntando al español en los cinco. El resto de
  grupos del sitio no se ha tocado.
- **JSON-LD** con el mismo patrón de bloques que sus equivalentes ES:
  `LocalBusiness + WebSite + Organization + FAQPage` en la home,
  `Product + LocalBusiness` en la flota, `CollectionPage + LocalBusiness` en el
  hub, y `Product + BreadcrumbList + LocalBusiness + FAQPage` en las dos
  landings. 468 bloques en total, validados offline: 0 errores.
- **Nav sin «Blog»** hasta la Entrega 3: no se manda a un lector italiano al
  blog inglés desde su propio menú. El footer lista las dos experiencias que ya
  existen en italiano y **enlaza las legales EN** con `hreflang="en"` y un
  `(in inglese)` visible, según la decisión del propietario.
- **CTA de reserva a `/booking` (EN)** hasta la Entrega 2, en la que el italiano
  tendrá formulario propio. Es lo más cercano que un lector italiano entiende
  sin fricción, y evita enlaces muertos. El recableado es un grep, documentado
  en el README. `form-tracking.js` no necesitó cambios: saca `lang` de
  `<html lang>`, así que el embudo de GA4 ya separa el italiano solo.
- **El patrón habla ES · EN · FR · RU**, y las páginas italianas lo dicen tal
  cual: en ningún sitio se afirma que se atienda en italiano. Ver §5.12.

**Deuda ajena corregida de paso.** El grep anti-invención, ahora un script
(`scripts/check-datos-comerciales.sh`) con patrones por idioma, destapó **13
páginas ya publicadas** que la limpieza de datos del 19/08 no había alcanzado:
equipo de sonido a bordo (ES, EN ×2, FR, RU ×3 — en HTML visible **y** en el
`FAQPage`), subir bebida propia (EN y FR), colchoneta flotante en cuatro posts
EN/FR/RU, y una botella «fría» para brindar. 35 sustituciones. Además, la card
de sunset de las 4 páginas de actividades seguía prometiendo tabla de quesos
—las 4 landings de sunset se habían corregido, la card no— y la tarjeta de
motores de las 4 portadas seguía mostrando `2× M` truncado, arreglado en su día
solo en las fichas de flota. El grep queda a **0 hits** en las 135 páginas.

### Champán: de copa a botella (19 de agosto de 2026)

El propietario **subió el detalle incluido**: donde el sitio decía «copa de champán
de cortesía» —dato que él mismo había confirmado esa misma mañana— ahora dice
**botella**. Una botella por reserva, incluida en la tarifa y en **todas** las
duraciones; no se promete marca, tamaño ni más de una.

- **77 páginas y 173 sustituciones** en los 5 idiomas publicados: ES 40 · EN 41 ·
  FR 34 · RU 46 · IT 12. HTML visible y `FAQPage` editados **a la vez** (misma
  sustitución literal sobre el archivo entero), más `meta description`, `og:` y
  `twitter:` de las páginas de sunset y de boat party, que la llevaban en la ficha
  del buscador.
- **Concordancia revisada a mano donde el cambio la rompe:** IT pasa de masculino a
  femenino (`un calice` → `una bottiglia`, `il calice` → `la bottiglia`) y RU
  cambia de caso según la frase (nominativo `бутылка`, instrumental `бутылкой` en
  el post de invierno, acusativo `бутылку` en la lista del post de precios).
- **Las botellas de pago pasan a llamarse «adicionales»** en las 11 frases donde se
  ofrecían como extra, para que no choquen con la incluida: ES «botellas
  adicionales», EN «additional bottle», FR «bouteilles supplémentaires», RU
  «дополнительные бутылки», IT «bottiglie aggiuntive». **Ningún extra del
  formulario de reserva era una botella de champán** —los cuatro son fotógrafo,
  moto de agua, catering ampliado y decoración especial—, así que no hubo nada que
  reformular ahí.
- **La redacción vieja queda prohibida por script:** `check-datos-comerciales.sh`
  incluye ahora la «copa/glass/coupe/бокал/calice de champán» como claim prohibido
  en los 8 idiomas. Si reaparece, es regresión.
- Actualizadas las **7 redacciones canónicas** (ES/EN/FR/RU/IT publicadas + NL/DE
  preparadas para su oleada) en `README.md`, aquí y en `docs/contexto-chat.md`.

**Deuda ajena corregida de paso:** el post RU de precios listaba «плавучий матрас»
(colchoneta flotante) dentro del equipo de playa incluido. La colchoneta es uno de
los claims que el propietario descartó el 19/08; el patrón RU del grep solo cubría
«надувной матрас» y no lo veía. Corregido y ampliado el patrón.

### Oleada IT, Entrega 2: landings de ocasión y formulario propio (19 de agosto de 2026)

Nueve páginas nuevas: las **8 landings de ocasión** que faltaban en italiano y el
**formulario de reserva `/prenota`**. Con esto el italiano tiene el sitio entero
menos el blog (Entrega 3).

**Alcance.** La lista definitiva se sacó del conjunto de landings que existen en
los idiomas ya publicados, no de una lista a ojo:

| Landing | Slug IT | Grupo `hreflang` |
|---|---|---|
| Despedida de soltero | `addio-al-celibato-barca-marbella` | 4 → 5 |
| Despedida de soltera | `addio-al-nubilato-barca-marbella` | 4 → 5 |
| Cumpleaños | `compleanno-in-barca-marbella` | 4 → 5 |
| Sunset tour | `sunset-tour-barca-marbella` | 4 → 5 |
| Delfines | `avvistamento-delfini-marbella` | 4 → 5 |
| Gibraltar | `escursione-barca-gibilterra-marbella` | 4 → 5 |
| Eventos de empresa | `eventi-aziendali-barca-marbella` | 4 → 5 |
| Comparativa directo vs plataformas | `barca-privata-vs-piattaforme` | 2 → 3 |
| **Formulario de reserva** | `prenota` | 4 → 5 |

**Dos decisiones de alcance, explícitas:**

- **La comparativa entra aunque su grupo solo tuviera 2 miembros** (ES y EN): es
  la página «por qué reservar directo», va enlazada desde el footer y es
  justamente el argumento que necesita un mercado nuevo. Su grupo pasa de 2 a 3.
- **El «boat party» queda fuera.** No existe como landing en **ningún** idioma:
  es un post de blog en los cuatro (`/post/boat-party-puerto-banus` y sus
  traducciones). Crear una landing italiana sin equivalente en ningún otro idioma
  sería arquitectura nueva, no localización, y dejaría un grupo `hreflang` de un
  solo miembro. Su sitio natural es la **Entrega 3**, con el resto del blog.

**Localización, no traducción.** El gancho italiano de cada landing parte de con
qué compara el lector: el addio al celibato/nubilato con la serata in discoteca
(sin lista all'ingresso ni consumazione minima) y con el *posto* comprado en una
gita collettiva; el compleanno con la cena per dieci al ristorante; la
comparativa con el **gommone a noleggio senza patente**, que es la formula que un
italiano tiene en la cabeza. En todas se repite que se alquila **la barca intera**
con **skipper abilitato**, así que **nessuna patente nautica richiesta**.

**Formulario `/prenota`.** No se escribió desde cero: se **transformó** el inglés
con sustituciones literales afirmadas una a una, de modo que hereda la misma
lógica ya probada. Lo propio del italiano son el `CFG` (formato `1.200 €`,
`Su preventivo`, mensaje de WhatsApp), el `CC` (errores, `def:"IT"`, +39) y la
**lista de 54 prefijos traducida y reordenada** por colación italiana. Probado en
navegador contra un servidor local con `window.open` y `fetch` interceptados: se
verificó que sin datos válidos no dispara nada, que los tres errores salen en
italiano, que el mensaje de WhatsApp sale entero y bien formateado, que
`/api/lead` recibe `lang:"it"` y que un `+34` pegado se mueve solo al selector.
**No se mandó ningún lead real.**

**Recableado.** Los **27** CTA de las 5 páginas de la Entrega 1 pasan de
`/booking` (EN) a `/prenota`. *(El README decía 22: era el recuento de una versión
anterior de esas páginas. Hoy son 27, y `grep -c` cuenta líneas, no ocurrencias.)*
El nav italiano **sigue sin «Blog»**: llega con la Entrega 3.

**Hub y footer.** Las **6 ocasiones que eran texto sin enlace** en
`/escursioni-barca-marbella` ahora enlazan a sus landings, y la rejilla crece a
**8** con eventos de empresa y la comparativa. El footer italiano de las 14
páginas pasa de 2 a **8 experiencias**, gana «Perché prenotare diretto» en Info y
el dato nuevo en Contatti.

**Dato comercial nuevo (confirmado por el propietario el 19/08/2026): se atiende
por WhatsApp y email en italiano.** Publicado **solo en las páginas IT**, con la
redacción canónica del README (`Assistenza in italiano su WhatsApp ed e-mail`) y
en los sitios donde convierte: junto a los CTA de la home, en el párrafo de
entrada y en la tarjeta lateral de las 8 landings, en la tarjeta de resumen de
`/prenota` y en el footer. **No se toca el patrón:** sigue hablando ES · EN · FR ·
RU y así lo dice la comparativa, que es la única página donde conviven los dos
datos — separados y en ese orden.

**Deuda ajena corregida de paso: la música a bordo.** Al localizar salió a la luz
una clase de claim que el grep no cubría. El propietario había confirmado el
19/08 que no había equipo de sonido a bordo *(dato que él mismo corrigió ese
mismo día: **sí lo hay**, ver «Equipo de sonido: de claim prohibido a claim
confirmado» más abajo — buena parte de lo que sigue quedó revertido)*, y sin
embargo:

- La landing ES de despedida de soltero —fuente directa de la italiana— ofrecía
  «barra premium con **DJ y altavoz portátil**» y «catering ampliado con marisco y
  **bebida fría**» (no hay nevera), en HTML visible **y** en el `FAQPage`.
  6 sustituciones.
- **12 páginas de los 4 idiomas** prometían literalmente «Música a bordo / Music
  on board / Musique à bord / Музыка на борту»: los 4 hubs de experiencias, las 4
  landings de cumpleaños y las pastillas del hero de las 4 de despedida de
  soltera. 12 sustituciones.
- Las **meta description** de 6 de esas páginas lo llevaban a la ficha del
  buscador (3 copias por página: `meta`, `og:` y `twitter:`). 18 sustituciones.

En total **36 sustituciones**. `check-datos-comerciales.sh` gana dos cosas: un
patrón **duro** por idioma para el equipo que tendríamos que poner nosotros
(altavoz, barra premium, DJ, bebida fría) y una lista **blanda** de revisión para
«música a bordo», que ya queda a 0. **Lo que no se ha tocado** son las ~120
menciones de «vuestra música / la playlist / coordinamos la música» repartidas por
el sitio: son zona gris y dependen de una pregunta al propietario — ver §5.

### Equipo de sonido: de claim prohibido a claim confirmado (19 de agosto de 2026)

**Sí hay equipo de sonido a bordo, con Bluetooth, y el cliente conecta su propia
música.** El propietario aclara la confirmación anterior del mismo día, que lo
daba por inexistente: la retirada de todas las menciones fue **decisión
editorial, no de existencia**. El dato vuelve al sitio con redacción sobria.

**Redacción canónica** (fuente única en `README.md` → «Regla anti-invención»):
ES `equipo de sonido con Bluetooth: conecta tu propia música` · EN `sound system
with Bluetooth: connect your own music` · FR `système audio avec Bluetooth :
connectez votre propre musique` · RU `аудиосистема с Bluetooth: подключайте свою
музыку` · IT `impianto audio con Bluetooth: collega la tua musica`, más NL y DE
preparadas para sus oleadas. **Límites:** ni DJ, ni barra, ni altavoces portátiles
adicionales, ni karaoke, ni marca o potencia del equipo. Nada de «premium sound».

**Dónde se ha publicado —y dónde no—, que es la parte que no es automática:**

| Criterio | Páginas | Cómo |
|---|---|---|
| Sí, visible | Las **20 landings de fiesta** (despedida de soltero, de soltera, cumpleaños y eventos de empresa × 5 idiomas) y los **4 posts de boat party** | Ítem de equipamiento en la tarjeta «Incluido» **y** en el párrafo de equipamiento del cuerpo. Nunca como titular. |
| Sí, en ficha | Las **5 fichas de flota** | Tarjeta propia en «Todo incluido a bordo», justo detrás de paddle surf y snorkel, más el párrafo de «lo que no hay que negociar aparte». |
| Sí, diferenciador | Las **3 comparativas** vs plataformas | «Suena vuestra playlist y no la del operador de turno», donde el contraste ya existía. |
| Restaurado | Las **4 cards de despedida de soltera** de los hubs y las **6 meta description** de landings de fiesta | Revierte lo que la tanda anterior quitó por editorial, con la redacción nueva. |
| **No** | Pedida, bodas, fotos de boda, sunset, delfines y Gibraltar | El tono de esas páginas es otro y ninguna tiene un bloque de equipamiento donde la ausencia chirríe. No se toca ninguna. |

**36 páginas** lo mencionan y **las 36 con la redacción canónica**.

**Una pastilla que no se ha restaurado.** La tanda anterior cambió «Música a
bordo» por «100% privado» en el hero de las 4 landings de despedida de soltera.
Se queda como está: una pastilla del hero es un titular, y el propietario pide el
dato **como ítem de equipamiento**. «100% privado» es cierto y vende igual.

**Las ~120 menciones en zona gris, revisadas y conservadas.** Eran el punto
§3.13 del backlog y dependían justo de esta respuesta. Repasadas una a una: todas
son compatibles con «conectar tu propia música al equipo de a bordo» —«ponéis
vuestra música», «coordinamos la playlist», «Musique douce diffusée à bord»,
«musique à fond», las secciones «Música y baile» de las landings de despedida— y
**ninguna promete más que eso**. No hay ni un DJ, ni un altavoz prestado, ni
karaoke, ni micrófono en todo el HTML publicado. **No se ha reescrito ninguna.**
La «música en vivo» de las 5 landings de pedida es otra cosa: aparece como
**extra a presupuestar** junto al fotógrafo y la decoración floral, que es como
estaba y como debe estar.

**Deuda ajena que aparece al revisar:** dos menciones habían sobrevivido a la
purga anterior porque el patrón del grep no las veía — `la sono` en la landing FR
de despedida de soltero (coloquial, no casaba con `système (audio|de son)`) y
`любимый плейлист через колонку` en la RU de cumpleaños. Las dos eran ciertas
todo el tiempo. La francesa pasa a la redacción canónica; la rusa se queda porque
ya describe exactamente lo que hay.

**El script cambia de bando.** `check-datos-comerciales.sh` deja de buscar el
equipo de sonido como claim prohibido y pasa a **vigilar su deriva**: toda mención
del equipo tiene que llevar «Bluetooth», la palabra que comparten las siete
redacciones canónicas. Una reescritura a mano rompe el build — probado
introduciendo «Premium sound system on board» a propósito: falla con exit 1.
Siguen prohibidos, ahora con patrón propio en los 5 idiomas: **DJ a bordo, barra
premium, altavoz portátil, karaoke**, más la nevera, el hielo y la bebida fría
como servicio.

### Oleada IT, Entrega 3: el blog italiano — oleada COMPLETA (19 de agosto de 2026)

Quince páginas nuevas: el **índice del blog italiano** y los **14 posts** que
replican los 14 grupos que existen en los cuatro idiomas. Con esto **la oleada
italiana se cierra**: el italiano es el quinto idioma del sitio a todos los
efectos, con 29 páginas.

**La lista salió del repo, no de memoria.** Se agruparon los 56 posts por sus
`hreflang` y salieron exactamente **14 grupos, los 14 con los 4 miembros
completos**: precios, licencia, calas, bodas y eventos, pedida, despedida
(consejos), boat party, Costa del Sol, invierno y los 5 de zona. Sin grupos
huérfanos ni monolingües que arrastrar.

**El único slug que no sale de la traducción.** El índice **no puede llamarse
`blog-nautico-marbella`**: en italiano «blog nautico» se escribe igual que en
español y ese slug ya es del ES. Se usa el sustantivo —**`blog-nautica-marbella`**,
de *la nautica*—, que en italiano se busca igual de bien. Conviene mirar si el
mismo choque se repite en neerlandés y alemán antes de abrir esas oleadas.

**Los 5 posts de zona no son clones.** Cada uno mantiene el ángulo diferencial
que tiene en los otros idiomas, con la capa italiana encima:

| Zona | Ángulo | Capa italiana |
|---|---|---|
| Estepona | 22 km y las calas de poniente *de camino a casa* | Por qué la geografía de aquí no premia el puerto más cercano |
| Sotogrande | El puerto ya lo tienen: lo que cambia es **quién hay detrás** | Charter directo frente a la plataforma de anuncios |
| Fuengirola | Barco entero frente a los barcos del paseo, **y el levante** | El paralelismo con la *gita collettiva* y el *posto* |
| Benalmádena | Qué cambia **a bordo** frente a la excursión de Puerto Marina | Cuatro diferencias enumeradas, no insinuadas |
| Málaga | La aritmética del día completo y el aeropuerto | Los vuelos directos desde Milán, Roma, Bolonia y Nápoles |

Medido: el solapamiento máximo de trigramas entre dos cualesquiera de los cinco
es del **17,2%**, y el cuerpo va de 668 a 915 palabras.

**Localización, no traducción**, también en el resto:

- **Licencia** — el lector llega del modelo de la *patente nautica entro le 12
  miglia*, así que el gancho es que aquí no le sirve de nada: skipper sempre
  incluso, nessuna patente. La escala española (titulín, PNB, PER, Patrón de
  Yate) se explica solo para el caso de querer conducir, y se dice con claridad
  que **el reconocimiento de un título extranjero no es automático y no depende
  de nosotros**.
- **Precios** — se contrasta con lo que el lector italiano conoce: el *gommone a
  ore* y el *posto* en una gita collettiva, y se pone el número que desarma la
  comparación (en diez, la jornada completa son 300 € por persona).
- **Boat party** — el grupo que quedó fuera de la Entrega 2 por ser post y no
  landing. Grupo 4→5.

**Recableado de cierre.** El nav italiano gana **«Blog»** en las 14 páginas de
las Entregas 1 y 2, y el footer el enlace al índice. La landing de addio al
nubilato enlaza al post de festa in barca —el patrón que sigue el español— y el
hub de esperienze enlaza al blog.

**`check-links.sh` conoce el índice italiano**, en el array `INDEXES` **y** en
`index_for_lang()`. Sin lo segundo la fase 1 habría marcado los 14 posts nuevos
como «idioma no reconocido»; sin lo primero la fase 2 no los recorrería. Ahora
recorre **153 URLs** y valida **70 posts sin huérfanos**.

### Oleada NL completa: las tres entregas (19 de agosto de 2026)

**El neerlandés es el sexto idioma del sitio**, con 29 páginas: 5 core, 8 landings
de ocasión, el formulario `/reserveren`, el índice `/vaarblog-marbella` y 14 posts.
Los **29 slugs se fijaron en el README antes de escribir una sola página** y se
contrastaron uno a uno contra las 159 URLs publicadas: cero colisiones.

**El gancho neerlandés no es el italiano.** El lector llega con el modelo de casa:
`sloep huren per uur` en la gracht o en de plassen, `rondvaart` donde compras una
plaza, y el `vaarbewijs`. Todo el sitio NL se apoya en ese contraste —de hele
boot, schipper siempre a bordo, ningún vaarbewijs (tampoco el neerlandés), tarifa
por embarcación y no per persoon— y en el segundo eje que ese mercado premia: la
**transparencia de precio**, `geen verrassingen, geen verborgen kosten`.

- **Entrega 1 — core.** `/nl`, `/vloot-boten-marbella`,
  `/activiteiten-boot-marbella`, `/huwelijksaanzoek-boot-marbella` y
  `/trouwfotos-boot-marbella`. 5 grupos `hreflang` de 5 a 6 miembros, con los
  30 miembros reescritos. Sitemap 159 → 164.
- **Entrega 2 — landings y formulario.** Las 8 landings de ocasión y
  `/reserveren`. **Son 9 páginas, no 10**: `vrijgezellenfeest` es unisex en
  neerlandés, así que las dos despedidas se desdoblan con `-man-` y `-vrouw-`,
  exactamente el mismo recuento que la Entrega 2 italiana. La comparativa entra
  con su grupo de 3 a 4. Sitemap 164 → 173.
- **Entrega 3 — blog.** `/vaarblog-marbella` y los 14 posts. Sitemap 173 → 188.

**El índice no calca al español ni al italiano.** «Nautische blog» es correcto y
no colisiona, pero no lo busca nadie: se usa **`vaarblog-marbella`**, de *varen*,
que es la palabra que un neerlandés asocia con salir al agua.

**El formulario `/reserveren` se transformó, no se escribió.** 32 sustituciones
estructurales y 82 de texto visible, cada una con su recuento exigido, de modo que
hereda la lógica ya probada. Lo propio del neerlandés es el `CFG` —`sep` `"."` y
`pre` `"€ "`, que hacen que `fmt()` rinda `€ 1.200`—, el `CC` con `def:"NL"`, +31
y errores en neerlandés, y la **lista de 54 prefijos reordenada con colación
neerlandesa** generada con `localeCompare('nl')`, la misma que usa el test:
`Ierland · IJsland · Israël` caen donde el lector los busca.
`test-booking-form.js` sube a 6 formularios: **380 → 456 comprobaciones**.

**Los 5 posts de zona no son clones, y menos que nunca.** Cada uno con su ángulo
exclusivo y con la lista de ángulos ajenos que tenía prohibido tocar:

| Zona | Ángulo |
|---|---|
| Estepona | La geografía no premia el puerto más cercano: las calas de poniente quedan de camino |
| Sotogrande | El puerto ya lo tienen; lo que cambia es **quién hay detrás** |
| Fuengirola | El barco entero frente a los barcos del paseo — el paralelismo con la `rondvaart` — y el levante |
| Benalmádena | Qué cambia **a bordo** frente a la excursión de Puerto Marina: cuatro diferencias enumeradas |
| Málaga | La aritmética del día completo y el aeropuerto |

Medido con trigramas de palabra sobre el `<main>`: el solapamiento máximo entre
dos cualesquiera es del **9,5 %** (Jaccard), frente al **17,7 %** de los cinco
italianos medidos igual. Cuerpos de 932 a 1.241 palabras.

**Deuda ajena corregida: los 65 km del aeropuerto.** La cifra correcta es la del
**centro** de Málaga, y así la miden bien los posts de zona ES/EN/FR, que además
avisan de que desde el aeropuerto es menos. La oleada italiana la reatribuyó al
**aeropuerto**, que está unos 8 km más cerca, y de ahí se extendió a 14 páginas.
Se retiró el número y se dejó el tiempo —45-60 minuti / een uur rijden—, correcto
desde los dos orígenes. 16 sustituciones.

**Lo que costó revisar, y que ningún script veía.** Los subagentes de redacción
**retiraron precios de extras confirmados** (`+120 €`, `+180 €`, `+250 €`)
creyéndolos inventados: viven en el formulario de reserva, que la regla
anti-invención nombra como fuente de verdad, y hubo que restaurarlos en seis
páginas. En sentido contrario, un brief demasiado restrictivo dejó la ruta a
Gibraltar sin el `vanaf € 3.000 + brandstof` que publican ES e IT, y también hubo
que restaurarlo, `Offer` incluido.

**`check-links.sh` conoce el índice neerlandés**, en `INDEXES` **y** en
`index_for_lang()`. Recorre **180 URLs** y valida **84 posts sin huérfanos**.
`check-datos-comerciales.sh` gana los patrones NL en las dos listas; el del hielo
lleva frontera de palabra porque sin ella «prijs inbegrepen» casaba como hielo
incluido. `check-offer-price.sh` pasa a vigilar **6** landings corporativas.

### Tarifa única todo el año, y dos FAQ que no cuadraban (19 de agosto de 2026)

Tanda corta de limpieza de deudas, las dos que la oleada neerlandesa había
destapado y dejado declaradas.

**No hay descuento de temporada baja** (confirmado por el propietario). La tarifa
es la misma todo el año. El post de invierno lo prometía **en español e inglés**,
y lo peor no era el cuerpo sino la **ficha del buscador**: `meta description`,
`og:`, `twitter:` y el `description` del JSON-LD anunciaban «precios más
económicos» / «better prices», y la tarjeta del índice remataba con «precios
especiales de octubre a mayo» / «special rates from October to May». El propio
cuerpo del post se contradecía: decía que «la tarifa base **se mantiene** desde
1.200 €». **16 sustituciones** en ES y EN; FR, RU, IT y NL ya lo decían bien y
no se han tocado. Lo que gana el invierno se dice ahora por lo que de verdad
gana: mar en calma, calas vacías y muchas más fechas libres.

`check-datos-comerciales.sh` gana el patrón **`temporada`** en los 6 idiomas.
Está escrito en **forma afirmativa** a propósito —`descuentos de temporada`,
`winter discount`, `korting in de winter`— y no como palabra suelta, porque las
**negaciones son legítimas** y no deben romper el build: el post NL dice
`geen korting` y el patrón no casa con él. Probado en los dos sentidos:
inyectando un positivo en ES, EN y NL el script sale con 1, y al retirarlo vuelve
a 0 hits.

**Los `FAQPage` que preguntaban cosas que no están en la página.** La deuda que
apareció al escribir el blog neerlandés era más ancha de lo declarado: no estaba
solo en el post de calas, también en el de invierno. **8 páginas realineadas**
—calas ES/EN/FR/RU e invierno ES/EN/FR/RU—, siempre con el HTML visible como
fuente, que es lo que Google exige para que el schema sea elegible.

| Página | Antes | Después |
|---|---|---|
| Calas ES / EN | 3 preguntas, **las 3** ausentes del cuerpo | las 3 visibles |
| Calas FR / RU | 3 preguntas, las 3 ausentes; **había 4 visibles** | las 4 visibles |
| Invierno ES / EN / FR | 1 huérfana («¿Es más barato…?») | 3 visibles |
| Invierno RU | **2** huérfanas | 3 visibles |

La FAQ «¿Es más barato alquilar un barco en invierno?» desaparece por las dos
razones a la vez: no estaba en la página y prometía algo que no existe. **IT y NL
cuadraban en los dos posts** y se verificaron sin tocarlos. Los pares Q/A
validados del sitio pasan de 550 a 552.

### Herramientas de verificación en el repo

| Script | Qué comprueba |
|---|---|
| `scripts/check-links.sh` | 0 enlaces rotos + 0 posts huérfanos del sitemap. **Obligatorio antes de cada push a `main`.** |
| `scripts/check-lang-switcher.py` | El selector de idioma del header no apunta a páginas inexistentes o de otro idioma. |
| `scripts/apply-lang-switcher.py` | Regenera el selector desde los `hreflang`. |
| `scripts/test-booking-form.js` | **456** comprobaciones sobre los **6** formularios (validación, prefijos, orden de ejecución, no-fuga a GA4). |
| `scripts/test-lead-api.js` | 21 comprobaciones de `/api/lead` con Resend simulado, sin red. |
| `scripts/check-offer-price.sh` | Que ningún `Offer` tenga `priceCurrency` sin `price` (6 landings corporativas). |
| `scripts/check-datos-comerciales.sh` | Que no se publique ningún claim que el propietario confirmó falso (sonido, nevera, hielo, descorche, ducha, colchoneta, alcohol incluido, tarifa de 6 h), en los 8 idiomas. **Obligatorio antes de cada push a `main`.** |

---

## 3. Pendiente — backlog de otoño

### Técnico (schema e i18n)

1. **Unificar `LocalBusiness` y `Organization` con `@id`.** Hoy conviven dos
   entidades de la misma empresa sin relación declarada: `Organization` tiene
   `@id` (`…/#organization`) y `LocalBusiness` no tiene ninguno. Dar `@id` al
   `LocalBusiness` y enlazarlos (`parentOrganization` / `sameAs`) para que Google
   las lea como una sola.
2. **Campo `url` en los 4 `Offer` corporativos.** Los `Offer` de las landings de
   eventos de empresa llevan `price`, `priceCurrency` y `availability`, pero no
   `url`. Es recomendado por Google y barato de añadir.
3. ~~**`hreflang` para los posts sin traducción.**~~ **RESUELTO** (agosto de 2026).
   No queda ningún post monolingüe: los 36 posts declaran los 4 alternates +
   `x-default`.
4. ~~**Traducir a FR y RU los posts que solo están en ES/EN.**~~ **RESUELTO**
   (agosto de 2026). Los cuatro grupos del Paquete A —licencia, Costa del Sol, bodas
   y boat party— están completos en ES/EN/FR/RU. Ver §2.

### Contenido y marketing

5. **Fotos reales.** Varias páginas repiten las mismas imágenes. Sustituirlas por
   fotos propias del D50 mejora conversión y da material para Google Business.
6. ~~**Experimento de landing en alemán.**~~ **SUPERADO** por el programa
   multiidioma (agosto de 2026). Lo que se descartó en su día fue abrir un quinto
   idioma *a partir de la demanda medida* (20 impresiones DE en 3 meses, Search
   Console); el propietario ha decidido después abrir cuatro —IT, NL, DE y AR— en
   oleadas, como apuesta y no como respuesta a la demanda actual. El alemán entra
   en la tercera oleada.

### Decisión comercial pendiente (no tocar hasta que el propietario confirme)

7. **Posibles actividades nuevas:** seabob, wakeboard, parada en beach club,
   tarjeta regalo. Ninguna se publica hasta que exista como producto real y con
   precio confirmado — ver regla anti-invención.
8. ~~**Equipamiento y bebida a bordo.**~~ **RESUELTO** (19/08/2026). El propietario
   confirmó: no hay nevera ni ducha de agua dulce *(el Bluetooth sí existe: lo
   aclaró después, ver §2)*; no se promete
   descorche; el único alcohol incluido es una **botella** de champán de cortesía
   (confirmó primero una copa y la corrigió a botella el mismo día); los globos solo
   dentro del extra de decoración; y el sunset lleva el mismo catering que el resto.
   Las 45 páginas afectadas se corrigieron en la misma tanda, y las 76 de la
   redacción del champán en la tanda de la botella. Ver §2.

### Programa multiidioma — lo que queda

9. ~~**Oleada IT, Entrega 2.**~~ **HECHA** (19/08/2026): 8 landings de ocasión +
   `/prenota`, 27 CTA recableados, hub y footer al día. Ver §2.
10. ~~**Oleada IT, Entrega 3.**~~ **HECHA** (19/08/2026): índice del blog
   italiano + los 14 posts, nav con «Blog», `check-links.sh` con el índice IT.
   **Con esto la oleada italiana está COMPLETA**: 29 páginas. Ver §2.

11. ~~**Oleada NL.**~~ **HECHA** (19/08/2026), las tres entregas: 29 páginas.
   Ver §2. Queda **una pregunta viva que la condiciona**: si se confirma que se
   atiende en neerlandés, hay que repasar las 29 páginas para añadirlo (§5.16).

12. **🔵 Oleada DE — la siguiente, y ya se puede abrir.** Mismas tres entregas.
   Antes de escribir una sola página: **fijar sus slugs en las tablas del
   README**, igual que se hizo con el italiano y el neerlandés. Lo aprendido en
   las dos oleadas anteriores, para no repetirlo:
   - **Comprobar los choques de slug con el español** antes de empezar. En
     italiano lo destapó el índice del blog; en neerlandés no hubo choque, pero
     el calco (`nautische blog`) tampoco servía porque nadie lo busca.
   - **Preguntar por la atención en ese idioma antes de escribir** (§5.15): en
     italiano la respuesta llegó a mitad de oleada y costó repasar 14 páginas;
     en neerlandés no llegó y las 29 páginas salieron sin el argumento.
   - **Decirle al brief de redacción que los precios de extras están
     confirmados** (`+120 €`, `+180 €`, `+250 €`, en el formulario de reserva).
     En neerlandés los subagentes los retiraron por su cuenta en seis páginas.
   - **No sobre-restringir el brief:** prohibir el precio de Gibraltar dejó esa
     página sin el `desde 3.000 € + combustible` que publican ES e IT.
   - **El formulario se transforma, no se escribe.** Sustituciones literales
     afirmadas sobre el inglés, y alta en `scripts/test-booking-form.js`.
   - **El nav va sin «Blog» hasta la Entrega 3**, y en esa entrega hay que dar
     de alta el índice en `check-links.sh` (los dos sitios) y recablear el nav
     y el footer de todas las páginas ya publicadas.
   - **El anti-clon de los 5 posts de zona sale mejor** si cada agente recibe su
     ángulo *y la lista de los ángulos ajenos que no puede tocar*: así el
     solapamiento bajó del 17,7 % (IT) al 9,5 % (NL).
   - Las redacciones canónicas DE de **lo incluido, puerto base, capacidad,
     motorización y equipo de sonido** ya están escritas en el README.
13. **Oleada AR — la última, y no se empieza hasta cerrar DE.** No es un idioma
   más: `dir="rtl"`, espejado de nav, footer, breadcrumbs y grids, tipografía e
   iconos direccionales, y una pasada de QA visual completa. La infraestructura
   del selector ya está preparada (ver README).

### Deuda detectada, acotada y cerrada

14. ~~**La «música» del sitio, en las ~120 menciones que quedan.**~~ **CERRADO**
   (19/08/2026). El propietario aclaró que **sí hay equipo de sonido con
   Bluetooth**: la pregunta que bloqueaba el punto ya tiene respuesta. Las ~120
   menciones se revisaron una a una y **se conservan todas** —ninguna promete más
   que conectar la propia música—, y el dato se publicó con redacción canónica en
   36 páginas. Ver §2.

---

## 4. Configuración externa

Referencias, **sin claves ni tokens**. Nada de esto vive en el repo.

| Servicio | Estado |
|---|---|
| **GA4** | Propiedad `G-5FQ4F67XC4`. Dimensiones y métricas personalizadas ya registradas (`step`, `last_step`, `duration`, `form_location`, `lang`, `guests`, `extras_count`, `date_offset`). Recuerda: no hay retroactividad, solo recogen datos desde su alta. |
| **Resend** | Dominio verificado; el remitente es `reservas@rentboatmarbella.com` y el aviso llega a `info@`. La credencial es la variable de entorno **`RESEND_API_KEY` en Vercel** — nunca en el repo, nunca en un log, nunca en una respuesta. |
| **Cookiebot** | Banner de consentimiento cargado en el `<head>` de todas las páginas. **Sin consentimiento de estadísticas no hay GA4**, por diseño: las cifras son de quien acepta cookies, no del total de visitas. |
| **Google Search Console** | Propiedad verificada, sitemap enviado. Es la fuente para las tandas de indexación y para validar las correcciones de schema. |
| **Vercel** | Deploy automático desde `main`. `vercel.json` define `cleanUrls`, redirecciones 301 y cabeceras de caché. |

---

## 5. Tareas del propietario (no son de código)

1. **Google Business Profile** — completar/reclamar la ficha. **Pendiente: el vídeo
   del amarre.** Cuando exista la URL de la ficha, añadirla al array `sameAs` del
   `LocalBusiness` (hoy solo está Instagram).
2. **Sistema de reseñas** — pedir reseña de Google a cada cliente de forma
   sistemática, no ocasional. Es lo que más mueve la SERP local.
3. **Validar en Search Console** las correcciones de precio de las landings
   corporativas (PR #11): marcar el problema como corregido y esperar la
   revalidación.
4. **Tandas de indexación restantes** — enviar a indexar las URLs nuevas o
   modificadas que aún no estén cubiertas.
5. **Menciones externas** — conserjerías de hoteles de la Milla de Oro, wedding
   planners, directorios náuticos y de turismo de la Costa del Sol.
6. **Revisión mensual de métricas** — embudo de GA4 (dónde se cae la gente) +
   Search Console (qué consultas entran). Cómo leerlo:
   [`docs/GA4-embudo-reserva.md`](docs/GA4-embudo-reserva.md).
7. **Vigilar la confusión de marca** con *rentalboatmarbella.com*, competidor de
   nombre casi idéntico.
8. **Datos aún no facilitados:** teléfono español `+34` (hay un hueco `TODO` en el
   footer, ahora solo se muestra el +33) y el pantalán/número de amarre exacto.
9. ~~**🔴 Confirmar qué hay de verdad a bordo.**~~ **RESUELTO** (19/08/2026) y, con
   esta tanda, aplicado a **todo** el HTML publicado: las 13 páginas que todavía
   prometían equipo de sonido, bebida propia o colchoneta flotante están
   corregidas y `scripts/check-datos-comerciales.sh` lo vigila a partir de ahora.
10. **Indexar las 20 URLs de los posts de zona** — Estepona, Sotogrande,
   Fuengirola, Benalmádena y Málaga en ES/EN/FR/RU. Repartirlas en tres días
   (7 + 7 + 6), priorizando Málaga y Estepona ES/EN, que son las de más volumen
   de búsqueda.
11. ~~**🟠 ¿Se atiende en italiano?**~~ **RESUELTO** (19/08/2026): sí, por
   **WhatsApp y email**. Publicado en las 14 páginas italianas con la redacción
   canónica del README, junto a los CTA y en el footer. **El patrón sigue
   hablando ES · EN · FR · RU** y ninguna página dice otra cosa. **La misma
   pregunta sigue abierta para NL, DE y AR**: hasta que se confirme, sus páginas
   no lo dirán.
12b. **Indexar las 29 URLs neerlandesas — la oleada entera.** Las 14 de las
   Entregas 1 y 2 (`/nl`, `/vloot-boten-marbella`, `/activiteiten-boot-marbella`,
   las 8 landings de ocasión, la comparativa y `/reserveren`) y las **15 de la
   Entrega 3**: `/vaarblog-marbella` y sus 14 posts. Repartirlas en tres o cuatro
   días y **empezar por el índice del blog**, que es la puerta de entrada al
   resto. Y **revalidar en Search Console los 29 grupos `hreflang` ampliados**:
   5 en la Entrega 1, 9 en la 2 y 15 en la 3 — al pasar de 5 a 6 miembros Google
   tarda en releer los alternates de las **116 páginas viejas** reescritas.

12. **Indexar las 29 URLs italianas — la oleada entera.** Las 14 de las Entregas
   1 y 2 (`/it`, flota, hub, las 8 landings de ocasión, la comparativa y
   `/prenota`) y las **15 de la Entrega 3**: `/blog-nautica-marbella` y sus 14
   posts. Repartirlas en tres o cuatro días y **empezar por el índice del blog**,
   que es la puerta de entrada al resto. Y **revalidar en Search Console los 29
   grupos `hreflang` ampliados**: 5 en la Entrega 1, 9 en la 2 y 15 en la 3. Al
   pasar de 4 a 5 miembros Google tarda en releer los alternates de las **94
   páginas viejas** reescritas a lo largo de la oleada.

13. **Indexar las 2 URLs de boat party** — `/post/fiesta-en-barco-puerto-banus`
   (nueva) y `/post/boat-party-puerto-banus` (title y meta reescritos). Pedir
   indexación en Search Console y, dentro de 3-4 semanas, comparar el CTR del post
   EN contra el 0 % actual (0 clics / 58 impresiones).

---

14. ~~**🟠 ¿Se puede subir un altavoz propio al barco?**~~ **RESUELTO**
   (19/08/2026), y por la vía corta: **hay equipo de sonido con Bluetooth a
   bordo**, así que no hace falta subir nada — se conecta el móvil. Las ~120
   menciones de «música» del sitio quedaron validadas de golpe y el dato se
   publicó en 36 páginas. Ver §2. *Lo que sigue sin existir, y sigue prohibido:
   DJ, barra premium, altavoces portátiles adicionales y karaoke.*

15. **🟠 ¿Se atiende también en neerlandés, alemán o árabe?** La respuesta al
   italiano fue que sí. Antes de abrir cada oleada conviene preguntarlo, porque
   cambia el argumento de conversión de todas sus páginas y es más barato
   escribirlo desde el principio que añadirlo después.

16. **🟠 ¿Se atiende en NEERLANDÉS por WhatsApp y email?** — pregunta viva, ya
   con páginas publicadas esperándola. La oleada NL arrancó **sin** el dato: en
   italiano estaba confirmado (`Assistenza in italiano su WhatsApp ed e-mail`) y
   para el neerlandés **no hay confirmación**, así que **ninguna de las páginas NL
   lo afirma**. Donde el italiano lo dice, el neerlandés dice lo único confirmado:
   `Schipper spreekt ES · EN · FR · RU`.
   - **Si la respuesta es sí:** hay que repasar las páginas NL publicadas para
     añadir la redacción canónica, igual que hubo que repasar 14 páginas italianas
     a mitad de oleada. Cuanto antes llegue, menos páginas hay que tocar.
   - **Si la respuesta es no:** conviene decidir si se publica **«English spoken»**
     como puente. Muchos neerlandeses aceptan sin fricción la atención en inglés,
     y decirlo explícitamente convierte mejor que el silencio — pero es una
     decisión comercial, no de código, y hoy no está tomada.
   **Con la oleada NL cerrada, la pregunta ya cuesta 29 páginas y no 5.**

17. ~~**🔴 ¿Existe de verdad un descuento de temporada baja?**~~ **RESUELTO**
   (19/08/2026): **no existe.** El propietario confirma **tarifa única todo el
   año** (2 h 1.200 € · 4 h 1.800 € · 8 h 3.000 €). El sitio ya no promete
   rebajas en ningún idioma: 16 sustituciones en ES y EN —`meta description`,
   `og:`, `twitter:`, el `description` del JSON-LD, el H3 «Mejores precios y
   flexibilidad», el cierre «el mismo barco premium por menos» y la tarjeta del
   índice— más la retirada de la FAQ «¿Es más barato…?», que además ni siquiera
   estaba en el HTML visible. FR, RU, IT y NL ya lo decían bien. **El script lo
   vigila**: `check-datos-comerciales.sh` gana el patrón `temporada` en los 6
   idiomas, escrito en forma afirmativa para que las negaciones legítimas —el
   `geen korting` del neerlandés, un «sin descuento»— no casen. Probado en los
   dos sentidos. Ver §2.

18. ~~**🟠 El `FAQPage` del post de calas no cuadra con su propia página.**~~
   **RESUELTO** (19/08/2026), y era más ancho de lo que parecía: la
   desincronización estaba también en los **posts de invierno**. En total **8
   páginas** realineadas (calas ES/EN/FR/RU y invierno ES/EN/FR/RU), tomando
   siempre el HTML visible como fuente. El ruso tenía dos preguntas huérfanas en
   vez de una; el francés y el ruso de calas ganan una cuarta pregunta que ya
   estaba en la página y que el schema no declaraba. IT y NL cuadraban en los
   dos posts, verificado. Ver §2.

---

## 6. Reglas del proyecto

Resumen de las reglas duras. La versión completa, en [`README.md`](README.md).

### Anti-invención de datos comerciales

**Todo dato comercial en contenido nuevo (precios, duraciones, capacidades,
extras, qué incluye una tarifa) debe existir previamente en la home o en el
formulario de reserva.** Si no existe, se marca `[CONFIRMAR CON PROPIETARIO]` y no
se publica. Nunca se completa con cifras plausibles inventadas.

Datos confirmados a día de hoy:

- **Tarifas:** 2 h → 1.200 € · 4 h → 1.800 € · 8 h (día completo) → 3.000 €.
  *No existe tarifa de 6 h ni de 2.400 €. No se publican equivalencias por hora
  (decisión expresa del propietario).*
- **Capacidad:** hasta **10** personas por barco.
- **Barco:** De Antonio D50, 15 m, año 2026, **2× Mercury V12 600 CV (1.200 CV)**.
- **Incluido:** patrón, combustible de la ruta habitual, seguro, paddle surf,
  snorkel, **catering ligero** (fruta y frutos secos), **agua y refrescos**, **una
  botella de champán de cortesía** e IVA. *(Confirmado el 19/08/2026; sustituye a la
  copa confirmada ese mismo día. Una botella por reserva, incluida en la tarifa y en
  todas las duraciones; no se promete marca, tamaño ni más de una.)* Redacción por
  idioma: ES `catering ligero, agua y refrescos, y botella de champán de cortesía` ·
  EN `light catering, water and soft drinks, and a complimentary bottle of champagne`
  · FR `catering léger, eau et sodas, et une bouteille de champagne offerte` · RU
  `лёгкий кейтеринг, вода и напитки, и бутылка шампанского в подарок` · IT
  `catering leggero, acqua e bibite e una bottiglia di champagne in omaggio`.
  Redacción canónica de NL/DE, en `README.md`.
- **El patrón habla ES · EN · FR · RU**, y eso es lo que dicen todas las páginas,
  también las italianas. **La atención escrita en italiano —WhatsApp y email— sí
  está confirmada** (19/08/2026) y se publica solo en las páginas IT, con la
  redacción canónica del README. Son dos datos distintos y no se mezclan. Para
  NL, DE y AR sigue sin confirmar: sus páginas no lo dirán. Ver §5.11 y §5.15.
- **Sí hay equipo de sonido a bordo, con Bluetooth** *(aclarado el 19/08/2026;
  corrige la confirmación anterior del mismo día)*. El cliente **conecta su propia
  música**. Se publica **solo con la redacción canónica** del `README.md` y solo
  donde el criterio editorial lo permite (landings de fiesta, posts de boat party,
  fichas de flota y comparativas; **no** en pedida, bodas, sunset, delfines ni
  Gibraltar). **Siguen sin existir y siguen prohibidos:** DJ, barra premium,
  altavoces portátiles adicionales y karaoke; tampoco se promete marca ni potencia
  del equipo. `check-datos-comerciales.sh` vigila las dos mitades.
- **No existe a bordo** (confirmado 19/08/2026): nevera, ducha de agua dulce y **colchoneta flotante** —el único equipo de agua es
  el paddle surf. **No se promete descorche.** El único alcohol
  incluido es la botella de champán de cortesía; las botellas **adicionales** siguen
  siendo extra de pago y hay que nombrarlas así para que no choquen con la incluida.
  Los globos solo dentro de «decoración especial (+120 €)». El **sunset lleva el
  mismo catering** que el resto de salidas.
- **Puerto base:** Puerto Banús (Marbella). **Salida desde otros puertos de la Costa
  del Sol** (Estepona, Sotogrande, Fuengirola, Benalmádena, Málaga…) **disponible a
  consultar** *(confirmado el 19/08/2026)*. Redacción canónica: ES «Puerto base:
  Puerto Banús. Salida desde [X] disponible a consultar.» · EN «Home port: Puerto
  Banús. Departure from [X] available on request.» · FR «Port d'attache : Puerto
  Banús. Départ depuis [X] possible sur demande.» · RU «Порт базирования:
  Пуэрто-Банус. Выход из [X] — по запросу.» **No se inventan** suplementos, precios
  de recogida, tiempos de traslado ni condiciones, y nunca se ofrece la salida desde
  X como estándar.
- **Formato de cifras:** ES `1.200€` · EN `€1,200` · FR/RU `1 200 €` · IT `1.200 €` · NL `€ 1.200` · DE `1.200 €`.

### Anti-regresión

`scripts/check-links.sh` **antes de cada push a `main`**. Si falla, no se hace
push. El blog se ha caído en producción dos veces; el script existe por eso. Si
tocas páginas o `hreflang`, además `scripts/check-lang-switcher.py`; y si tocas
contenido, `scripts/check-datos-comerciales.sh`.

### La analítica nunca captura datos personales

El código de medición **no lee jamás el `.value`** de nombre, email, teléfono ni
peticiones especiales. Del bloque de contacto solo se registra que hubo
interacción. Esos datos viajan únicamente en el mensaje de WhatsApp que envía el
propio cliente y en el email de `/api/lead`. Cualquier cambio en `form-tracking.js`
tiene que mantener esta propiedad.

### Versionado de assets

`mobile.css` y los `.js` se sirven con `max-age=31536000, immutable`. **Al editar
uno de esos ficheros hay que subir el `?v=` de su etiqueta en todas las páginas
que lo cargan**, o los visitantes recurrentes verán el HTML nuevo con el asset
viejo. Desde esta tanda la versión se declara **en un solo sitio**: `CSS_V` y
`JS_V` en `scripts/apply-lang-switcher.py`, que la propaga a las 144 páginas al
reejecutarse. Valores actuales: `mobile.css?v=3`, `lang-switcher.js?v=2`
(esta tanda **no** tocó ni `mobile.css` ni `js/`, así que no hubo bump).

---

## Cómo mantener este documento

Al cerrar una tanda de trabajo: mueve lo hecho de la sección 3 a la 2 en una
línea, añade lo nuevo que haya aparecido al backlog y actualiza la fecha de
cabecera. El detalle técnico va en `SEO-CHANGELOG.md`; aquí solo el estado.
