# Estado del proyecto — rentboatmarbella.com

**Documento vivo.** Última actualización: **19 de agosto de 2026** (4.ª tanda del día).
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
por medio. Cuatro idiomas con URLs traducidas: **ES / EN / FR / RU**.

**Stack:** HTML estático puro, sin framework ni paso de build. Desplegado en
**Vercel** desde `main` (`cleanUrls: true`, `trailingSlash: false`); cada push a
`main` despliega. Una única función serverless (`api/lead.js`) que envía el aviso
de cada solicitud por **Resend**. Medición con **GA4**, consentimiento con
**Cookiebot**.

**Tamaño actual:** 110 URLs en el sitemap · 36 posts de blog · 4 formularios de
reserva (uno por idioma) · 372 bloques JSON-LD validados.

**Estado general:** el sitio está **completo y en producción**. Las tandas de julio
y agosto de 2026 (PR #1 a #15) cerraron los problemas críticos (404 del blog,
accesibilidad, schema, formulario que perdía los datos de contacto). Lo que queda
es afinado, contenido y decisiones comerciales — nada bloqueante.

---

## 2. Hecho

### Base y contenido (julio 2026 — Fases 1 a 6 del plan SEO)

- **Blog reparado.** Los `/post/...` enlazados desde los índices no existían: 404
  en todo el blog. Creados los posts y, desde entonces, un script anti-regresión
  impide que vuelva a pasar. Hoy: **36 posts** en 4 idiomas, todos enlazados desde
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
- **`sitemap.xml`** con 110 URLs, sin rotas, referenciado desde `robots.txt`.
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

- **Fuera:** equipo de sonido / Bluetooth (14 páginas), política de descorche (14),
  «agua y hielo» como claim (11), nevera y ducha de agua dulce (6), y los globos
  prometidos sueltos, que ahora solo aparecen dentro del extra de decoración (+120 €).
- **Dato nuevo incluido:** una **copa de champán de cortesía**, añadida a las
  enumeraciones canónicas —respuesta «¿Qué incluye el precio?» y tarjeta de catering
  de las 4 homes, párrafo y tarjeta de tarifa de las 4 fichas de flota, FAQ del
  sunset— editando `FAQPage` y HTML visible a la vez para que no se desincronicen.
- **Las 4 landings de sunset corregidas:** fuera la tabla de quesos y embutidos y la
  botella para brindar; el sunset lleva el mismo catering que el resto de salidas.
  Era lo único del sitio que prometía algo que podía no entregarse.
- Las botellas de champán **como extra de pago siguen siendo correctas** y se han
  dejado: copa incluida, botella extra.

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

### Herramientas de verificación en el repo

| Script | Qué comprueba |
|---|---|
| `scripts/check-links.sh` | 0 enlaces rotos + 0 posts huérfanos del sitemap. **Obligatorio antes de cada push a `main`.** |
| `scripts/check-lang-switcher.py` | El selector de idioma del header no apunta a páginas inexistentes o de otro idioma. |
| `scripts/apply-lang-switcher.py` | Regenera el selector desde los `hreflang`. |
| `scripts/test-booking-form.js` | 304 comprobaciones sobre los 4 formularios (validación, prefijos, orden de ejecución, no-fuga a GA4). |
| `scripts/test-lead-api.js` | 21 comprobaciones de `/api/lead` con Resend simulado, sin red. |
| `scripts/check-offer-price.sh` | Que ningún `Offer` tenga `priceCurrency` sin `price`. |

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
6. ~~**Experimento de landing en alemán.**~~ **NO — descartado con datos**
   (**20 impresiones DE en 3 meses**, Search Console, agosto de 2026). No hay
   demanda que justifique abrir un quinto idioma. Revisar solo si esa cifra cambia
   de orden de magnitud.

### Decisión comercial pendiente (no tocar hasta que el propietario confirme)

7. **Posibles actividades nuevas:** seabob, wakeboard, parada en beach club,
   tarjeta regalo. Ninguna se publica hasta que exista como producto real y con
   precio confirmado — ver regla anti-invención.
8. ~~**Equipamiento y bebida a bordo.**~~ **RESUELTO** (19/08/2026). El propietario
   confirmó: no hay Bluetooth, nevera ni ducha de agua dulce; no se promete
   descorche; el único alcohol incluido es una copa de champán de cortesía; los
   globos solo dentro del extra de decoración; y el sunset lleva el mismo catering
   que el resto. Las 45 páginas afectadas se corrigieron en la misma tanda. Ver §2.

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
9. **🔴 Confirmar qué hay de verdad a bordo** — equipo de sonido Bluetooth, política
   de descorche (si el cliente puede subir su propia bebida), si el alcohol entra en
   las bebidas incluidas, y nevera / ducha de agua dulce / banda de globos. Bloquea
   contenido nuevo y hay tres páginas publicadas que ya lo afirman sin confirmar:
   ver el punto 8 del backlog (§3).
10. **Indexar las 2 URLs de boat party** — `/post/fiesta-en-barco-puerto-banus`
   (nueva) y `/post/boat-party-puerto-banus` (title y meta reescritos). Pedir
   indexación en Search Console y, dentro de 3-4 semanas, comparar el CTR del post
   EN contra el 0 % actual (0 clics / 58 impresiones).

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
  copa de champán de cortesía** e IVA. *(Confirmado el 19/08/2026.)*
- **No existe a bordo** (confirmado 19/08/2026): equipo de sonido / Bluetooth,
  nevera, ducha de agua dulce y **colchoneta flotante** —el único equipo de agua es
  el paddle surf. **No se promete descorche.** El único alcohol
  incluido es la copa de champán; las botellas siguen siendo extra de pago. Los
  globos solo dentro de «decoración especial (+120 €)». El **sunset lleva el mismo
  catering** que el resto de salidas.
- **Puerto base:** Puerto Banús (Marbella). **Salida desde otros puertos de la Costa
  del Sol** (Estepona, Sotogrande, Fuengirola, Benalmádena, Málaga…) **disponible a
  consultar** *(confirmado el 19/08/2026)*. Redacción canónica: ES «Puerto base:
  Puerto Banús. Salida desde [X] disponible a consultar.» · EN «Home port: Puerto
  Banús. Departure from [X] available on request.» · FR «Port d'attache : Puerto
  Banús. Départ depuis [X] possible sur demande.» · RU «Порт базирования:
  Пуэрто-Банус. Выход из [X] — по запросу.» **No se inventan** suplementos, precios
  de recogida, tiempos de traslado ni condiciones, y nunca se ofrece la salida desde
  X como estándar.
- **Formato de cifras:** ES `1.200€` · EN `€1,200` · FR/RU `1 200 €`.

### Anti-regresión

`scripts/check-links.sh` **antes de cada push a `main`**. Si falla, no se hace
push. El blog se ha caído en producción dos veces; el script existe por eso. Si
tocas páginas o `hreflang`, además `scripts/check-lang-switcher.py`.

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
viejo.

---

## Cómo mantener este documento

Al cerrar una tanda de trabajo: mueve lo hecho de la sección 3 a la 2 en una
línea, añade lo nuevo que haya aparecido al backlog y actualiza la fecha de
cabecera. El detalle técnico va en `SEO-CHANGELOG.md`; aquí solo el estado.
