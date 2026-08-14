# Estado del proyecto — rentboatmarbella.com

**Documento vivo.** Última actualización: **14 de agosto de 2026**.
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

**Tamaño actual:** 100 URLs en el sitemap · 26 posts de blog · 4 formularios de
reserva (uno por idioma) · 332 bloques JSON-LD validados.

**Estado general:** el sitio está **completo y en producción**. Las tandas de julio
y agosto de 2026 (PR #1 a #15) cerraron los problemas críticos (404 del blog,
accesibilidad, schema, formulario que perdía los datos de contacto). Lo que queda
es afinado, contenido y decisiones comerciales — nada bloqueante.

---

## 2. Hecho

### Base y contenido (julio 2026 — Fases 1 a 6 del plan SEO)

- **Blog reparado.** Los `/post/...` enlazados desde los índices no existían: 404
  en todo el blog. Creados los posts y, desde entonces, un script anti-regresión
  impide que vuelva a pasar. Hoy: **26 posts** en 4 idiomas, todos enlazados desde
  el índice de su idioma.
- **Schema completo** en las 100 páginas: `LocalBusiness` (con `legalName` y
  `taxID` reales), `Product` + `Offer`, `FAQPage`, `BlogPosting`,
  `BreadcrumbList`, y `Organization` + `WebSite` en las 4 homes. 332 bloques
  JSON-LD validados offline contra el vocabulario oficial de schema.org: 0 errores.
- **Accesibilidad WCAG AA** (PR #2, #3): labels, `aria`, `main`, contraste del
  naranja de marca corregido a navy/ámbar. Lighthouse móvil: accesibilidad **96**,
  buenas prácticas 100, SEO 100. El único fallo pendiente es el contraste del
  footer.
- **Rendimiento:** 17 imágenes JPG → WebP (**20 MB → 1,7 MB, −92 %**), `<picture>`
  con fallback, `fetchpriority` en el LCP y `loading="lazy"` en el resto. PageSpeed
  88–99.
- **i18n:** `hreflang` recíproco ES/EN/FR/RU + `x-default` en todos los grupos de
  páginas traducidas; nav, footer y breadcrumb siempre en el idioma de la página.
- **Legal:** Aviso Legal, Privacidad, Términos y Cookies en los 4 idiomas (16
  páginas) con datos fiscales reales.
- **`sitemap.xml`** con 100 URLs, sin rotas, referenciado desde `robots.txt`.
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
3. **`hreflang` para los 2 posts sin traducción.** `post/boat-party-puerto-banus`
   (EN) y `post/bodas-eventos-barco-marbella` (ES) declaran un solo alternate. Se
   resuelve solo al traducirlos; mientras tanto están correctos como páginas
   monolingües.
4. **Traducir a FR y RU los posts que solo están en ES/EN.** Quedan tres grupos
   del Paquete A: licencia (`necesitas-licencia…` / `do-you-need-licence…`), Costa
   del Sol (`alquiler-barco-costa-del-sol…` / `boat-rental-costa-del-sol…`) y los
   dos monolingües del punto anterior. Mismo criterio que en agosto:
   **localización, no traducción literal** (adaptar gancho, ejemplos y referencias
   a cada mercado).

### Contenido y marketing

5. **Fotos reales.** Varias páginas repiten las mismas imágenes. Sustituirlas por
   fotos propias del D50 mejora conversión y da material para Google Business.
6. **Experimento de landing en alemán.** Solo **si los datos lo justifican**
   (tráfico DE en Search Console / GA4). No abrir un quinto idioma por intuición.

### Decisión comercial pendiente (no tocar hasta que el propietario confirme)

7. **Posibles actividades nuevas:** seabob, wakeboard, parada en beach club,
   tarjeta regalo. Ninguna se publica hasta que exista como producto real y con
   precio confirmado — ver regla anti-invención.

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
- **Incluido:** patrón, combustible de la ruta habitual e IVA.
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
