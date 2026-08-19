# SEO Changelog — rentboatmarbella.com

Resumen de la ejecución del plan de acción SEO (`SEO-TODO-rentboatmarbella.md`). Julio 2026.

**Stack:** sitio HTML estático puro desplegado en Vercel (`cleanUrls:true`, `trailingSlash:false`). Sin framework ni paso de build. i18n por URLs traducidas (ES/EN/FR/RU). Páginas totales: **76** (eran 58).

---

## Lo que se ha hecho

### Fase 1 — Reparación de los 404 del blog (crítico)
- Los 5 posts del blog ES no existían (no había carpeta `post/`). **Creados y publicados** en `post/`:
  - `cuanto-cuesta-alquilar-barco-marbella` · `mejores-calas-fondear-marbella` · `alquilar-barco-marbella-invierno` · `despedida-soltera-barco-consejos` · `pedida-matrimonio-en-el-mar`
- Creadas también las versiones **FR** (`combien-coute-location-bateau-marbella`) y **RU** (`skolko-stoit-arenda-yakhty-marbella`) del post de precios, para cerrar los 404 de los blogs FR/RU.
- Cada post: `title` ≤ 60 con keyword, meta description 150–160 con CTA, 1 solo H1, jerarquía H2/H3, keyword en las primeras 100 palabras, enlaces internos a landings + `/reservar`, y JSON-LD **BlogPosting + BreadcrumbList + FAQPage**.
- **Resultado: cero 404 internos** en todo el sitio.

### Fase 2 — Quick wins técnicos
- **LocalBusiness** JSON-LD en las 76 páginas (`additionalType` BoatRental, `areaServed`, `priceRange:"€€€€"`, `sameAs` Instagram, dirección Puerto Banús + geo).
- **FAQPage** ya presente en las 4 homes; **Product/Offer** en todas las landings.
- **Páginas legales**: Aviso Legal, Política de Privacidad, Términos y Condiciones y Política de Cookies en **los 4 idiomas** (16 páginas), con hreflang recíproco, enlazadas en el footer de cada idioma y en el sitemap. Datos fiscales reales incorporados (ver "Datos de empresa" abajo); sin placeholders.
- Hueco `TODO: +34` añadido en el footer de todas las páginas.
- **Formato de cifras** unificado: EN `€1,200`; FR/RU `1 200 €`; ES `1.200€`.
- Selectores de reserva verificados (ya ordenados 2 h → 4 h → 8 h → a medida).
- `robots.txt` + `sitemap.xml` (76 URLs, sin rotas). hreflang recíproco ES/EN/FR/RU + x-default.

### Fase 3 — Contenido de landings (ES)
- **9 landings de experiencia ES** ampliadas a 600–900 palabras con sección de contenido (qué incluye, ruta, para quién, mini-FAQ con FAQPage) + enlaces internos.
- **H1 de la home** cambiado a `Alquiler de barco privado en Marbella — De Antonio D50` (categoría→modelo) en los 4 idiomas.
- Nueva página **`/barco-privado-vs-plataformas`** (chárter privado directo vs marketplaces).
- Verificado: **cero páginas huérfanas**.

### Fase 4 — Internacionalización
- **5 posts EN** (UK: "hen party", "boat hire", "marriage proposal") + página **`/private-boat-vs-rental-platforms`**. Blog EN repuntado a los posts EN + tarjeta de precios.
- **9 landings EN** ampliadas a 600–900 palabras con FAQPage (paridad con ES).
- **FR y RU**: ampliadas las 2 landings principales (sunset + despedida) en cada idioma.
- hreflang recíproco ES↔EN en posts y páginas de diferenciación.

### Fase 5 — Rendimiento
- **17 imágenes JPG → WebP** (máx. 1920px, q80): **20 MB → 1,7 MB (−92 %)**.
- 146 `<img>` envueltos en `<picture>` con `<source type="image/webp">` + fallback JPG; 52 heroes CSS `background-image` a `.webp`.
- `fetchpriority="high"` en LCP, `loading="lazy"` en el resto. Scripts de terceros ya async/diferidos.

### Fase 6 — Verificación
- ✅ Cero 404 internos · ✅ Cero cadenas de redirección · ✅ Cero páginas huérfanas
- ✅ Todos los JSON-LD válidos · ✅ 1 H1 por página · ✅ Titles y metas únicos
- ✅ Canonicals a `https://www.rentboatmarbella.com` · ✅ Sitemap XML válido y referenciado en robots.txt

---

## Datos de empresa incorporados (julio 2026)

- **Razón social / `legalName`:** Bulgarian Business Management Company EOOD
- **NIF / `taxID`:** N0396825B
- **Domicilio social (solo en Aviso Legal):** Complejo Resid. Yuzhen Park, Bl. 123, Pl. 5 – Apto. 18, Distrito de Triaditsa, 1421 Sofía (Bulgaria)
- **Nombre comercial (`name` en schema):** Rent Boat Marbella · **Amarre / `address`:** Puerto Banús, 29660 Marbella (Málaga)
- Añadidos `legalName` y `taxID` al schema LocalBusiness de las 86 páginas; nombre comercial intacto; `address` sigue siendo el amarre de Puerto Banús (la dirección de Sofía solo figura en el Aviso Legal).

## Pendiente de datos del propietario (Claude Code no puede completarlo)

1. **Teléfono +34**: hay un hueco `TODO` en el footer de todas las páginas (ahora se usa el +33). Facilitar el número español para mostrarlo junto al +33.
2. **Dirección exacta del amarre**: el schema usa "Puerto Banús, 29660 Marbella". Confirmar pantalán/número de amarre exacto (mejora la SERP local y coincidencia con Google Business).
3. **Google Business Profile**: añadir su URL al array `sameAs` del LocalBusiness (ahora solo Instagram) y completar/reclamar la ficha.

## Traducción FR/RU de los 4 posts pendientes (agosto 2026)

Los 4 posts que solo existían en ES ya están en los 4 idiomas. **Localización, no traducción literal**:
se adaptaron el gancho, los ejemplos y las referencias a cada mercado (en FR: comparación con las
calanques de Cassis y Porquerolles, vuelos directos a Málaga, vacaciones escolares, terminología EVJF/EVG
y coste por persona; en RU: público que inverna en la costa y viaja en las vacaciones de fin de año,
topónimos transliterados —Пуэрто-Банус, Кабопино, Ла-Конча—), manteniendo la misma estructura de
H2/H3, los CTAs y el JSON-LD del original ES.

| Post ES | FR | RU |
|---|---|---|
| `mejores-calas-fondear-marbella` | `meilleures-criques-mouillage-marbella` | `luchshie-buhty-marbella` |
| `alquilar-barco-marbella-invierno` | `louer-bateau-marbella-hiver` | `arenda-yakhty-marbella-zimoy` |
| `despedida-soltera-barco-consejos` | `evjf-bateau-marbella-conseils` | `devichnik-na-yakhte-sovety` |
| `pedida-matrimonio-en-el-mar` | `demande-mariage-en-mer` | `predlozhenie-ruki-v-more` |

- **Datos comerciales:** solo los confirmados (2 h → 1 200 € · 4 h → 1 800 € · 8 h → 3 000 €, hasta 10
  personas, patrón + combustible + IVA incluidos). Formato de cifras por locale (`1 200 €` en FR y RU).
  Sin tarifa de 6 h ni 2 400 €.
- **Índices:** recuperadas las cards en `/blog-nautique` y `/morskoy-blog` (grid de 4, cada uno en su idioma).
- **hreflang:** los 4 grupos pasan de 3 a 5 alternates (`es`/`en`/`fr`/`ru`/`x-default`→ES) en las 16 páginas.
- **Sitemap:** +8 URLs (100 en total, sumando las 6 del Paquete A). Nav/footer/breadcrumb 100 % en el
  idioma de la página; logo y breadcrumb «Accueil»/«Главная» apuntan a `/fr` y `/ru` (no a la home ES).
- **Además:** logo, breadcrumb visible y `BreadcrumbList` de los 3 posts de precios EN/FR/RU
  remapeados a `/en`, `/fr` y `/ru` (resto del bug de plantilla de `bb19659`), y `check-links.sh`
  endurecido para que un 200 tras redirigir a otro host (Preview con SSO) cuente como fallo.

## Backlog SEO (mejoras futuras)

- ~~**[PRIORITARIO]** Traducir a FR y RU los 4 posts del blog que solo existían en ES~~ ✅ **hecho (agosto 2026)** — ver «Traducción FR/RU de los 4 posts pendientes» más abajo.
- ~~Ampliar el resto de landings FR/RU a 600–900 palabras~~ ✅ **hecho** (las 14 landings FR/RU ampliadas).
- **AVIF** y `srcset`/`sizes` multi-ancho (la conversión a WebP ya captura el mayor ahorro).
- Ejecutar **Lighthouse** tras el deploy en Vercel y comparar (baseline no capturada por falta de entorno servido; mejora esperada alta por la reducción de imágenes).

## Tareas manuales de marketing (del plan original)

- Completar/reclamar Google Business Profile con fotos reales del De Antonio D50.
- Pedir reseñas de Google a cada cliente.
- Verificar propiedad en Google Search Console y enviar el sitemap.
- Alta en directorios náuticos/turismo Costa del Sol; conserjerías de hoteles de la Milla de Oro.
- Vigilar la confusión de marca con *rentalboatmarbella.com* (competidor de nombre casi idéntico).

---

## Paquete A — Contenido nuevo basado en datos de Search Console (agosto 2026)

### Posts nuevos (6)
Mismo patrón que el resto del blog: `title` ≤ 60 con keyword, meta description 150–160, un solo H1, keyword en las primeras 100 palabras, mini-FAQ con **FAQPage** + **BlogPosting** + **BreadcrumbList**, 2–4 enlaces internos contextuales y CTA a reserva. 1.000–1.300 palabras cada uno.

| Post | Idioma | Keywords objetivo |
|---|---|---|
| `necesitas-licencia-alquilar-barco-marbella` | ES | alquiler barco sin licencia marbella |
| `do-you-need-licence-rent-boat-marbella` | EN | boat hire with licence costa del sol |
| `bodas-eventos-barco-marbella` | ES | yates para eventos marbella · alquiler de yates para bodas marbella |
| `boat-party-puerto-banus` | EN | puerto banus boat party · boat party marbella |
| `alquiler-barco-costa-del-sol-puerto-banus` | ES | alquiler lancha premium costa del sol |
| `boat-rental-costa-del-sol-puerto-banus` | EN | boat rental costa del sol |

- **hreflang recíproco ES/EN** (+ `x-default` → ES) entre los pares de licencia y de Costa del Sol.
- El post geográfico es **uno solo** para toda la costa: no se han creado páginas por ciudad.
- Datos comerciales exclusivamente de la tabla confirmada (2 h/4 h/8 h, capacidad 10, patrón + combustible + IVA incluidos) y de los extras del formulario de reserva (moto de agua +250 €, catering ampliado +180 €, decoración +120 €, fotógrafo a consultar).

### Guía de precios — decisión del propietario
Se evaluó añadir una sección H2 "Alquiler de barco por horas en Marbella" (keyword *alquiler barco marbella por horas*) con el precio por hora resultante de cada bloque. **Descartada por decisión del propietario: no se publican equivalencias por hora.** La guía se mantiene solo con las tarifas cerradas 2 h / 4 h / 8 h. No reintroducir sin confirmación expresa.

### Enlaces internos hacia páginas top-10
- **Home FR** → `/anniversaire-yacht-marbella` y `/demande-mariage-yacht-marbella` (párrafo contextual en la sección de experiencias).
- **Home ES** y **guía de precios ES** → `/barco-privado-vs-plataformas`.
- **Home EN** → `/fleet` (en el bloque del De Antonio D50).

### Integración
Cards añadidas a `/blog-nautico-marbella` (3) y `/yacht-blog` (3), 6 URLs nuevas en `sitemap.xml`. `scripts/check-links.sh` ejecutado contra servidor local con emulación de `cleanUrls`: **87 URLs, 0 fallos**.

---

## Salvaguarda: posts huérfanos del sitemap (agosto 2026)

`scripts/check-links.sh` solo comprobaba que las URLs **enlazadas desde los índices** respondieran 200. Eso deja un hueco: un post publicado y presente en `sitemap.xml` al que ningún índice enlaza responde 200 y el script daba verde, pero el post es invisible en el blog para el usuario y prácticamente huérfano para Google.

El script pasa ahora a tener dos fases:

1. **Fase 1 (offline)** — para cada `<loc>.../post/<slug>` del sitemap se lee el idioma del propio post (`<html lang="xx">`) y se exige que su índice lo enlace: `es`→`blog-nautico-marbella`, `en`→`yacht-blog`, `fr`→`blog-nautique`, `ru`→`morskoy-blog`. También falla si el sitemap lista un post que no existe en `post/` o con idioma no reconocido.
2. **Fase 2 (red)** — la comprobación de 200 con cache-buster que ya existía.

Falla (exit 1) si falla cualquiera de las dos. Estado actual en main: **87 URLs, 0 fallos · 18 posts del sitemap, 0 huérfanos.**

---

## Auditoría externa — correcciones (agosto 2026)

Cinco hallazgos de una auditoría externa, verificados uno a uno contra el repo antes de corregir.

### 1. Ficha técnica: motorización truncada
La tarjeta de motores de la ficha de flota mostraba `2× M` (campo cortado) en los **4 idiomas**. Sustituida por la motorización real, con el formato de cifras de cada locale:

| Idioma | Valor | Etiqueta |
|---|---|---|
| ES | `1.200 CV` | Motores · 2× Mercury V12 600 CV |
| EN | `1,200 hp` | Engines · 2× Mercury V12 600 hp |
| FR | `1 200 ch` | Moteurs · 2× Mercury V12 600 ch |
| RU | `1 200 л.с.` | Двигатели · 2× Mercury V12 600 л.с. |

La potencia se añade también al `Product` de cada ficha vía `additionalProperty` (`PropertyValue`), y el dato entra en la **tabla de datos confirmados del README** junto a tarifas y capacidad (regla anti-invención).

### 2. Residuos de "12" (capacidad antigua)
Grep global de `12 guests` / `12 invitados` / `12 человек` / `12 personnes` / `12 pax` (+ variantes en letra y regex de proximidad) sobre las 100 páginas: **2 ocurrencias reales**, ambas en `sunset-tour-yacht-marbella.html` (texto visible + `FAQPage`). Corregidas a **10**. ES/FR/RU ya decían 10. El resto de resultados que Google pudiera mostrar con "12" es caché del sitio anterior.

### 3. Organization + WebSite en las 4 homes
`WebSite` ya existía. Añadido **`Organization`** (`@id` `…/#organization`, `name`, `legalName` "Bulgarian Business Management Company EOOD", `url`, `logo` 512×512, `sameAs` Instagram) y enlazado desde `WebSite` con `publisher`. El icono de marca vivía solo en `brand-assets/` (ignorado por git → 404 en producción); se publica como `img/logo-icon-512.png`.

### 4. Ficha de flota ampliada (4 idiomas)
Nueva sección de ~330–410 palabras por idioma reforzando el ángulo **privacidad + lugar** (*yate privado en Puerto Banús* / *private yacht charter Puerto Banús*), con el D50 como producto que lo hace creíble: specs completas (15 m, 10 pax, 2× Mercury V12 600 CV, 2026), qué lo diferencia de un alquiler típico y por qué un solo barco premium en vez de una flota. Sin perseguir la keyword del modelo. Datos comerciales exclusivamente de la tabla confirmada.

### 5. Footer: "FB" sin enlace
El cuadro `FB` del footer era texto plano sin `href` (no hay página de Facebook activa). **Eliminado de las 100 páginas**; queda solo el icono de Instagram enlazado.

### Verificación
- `scripts/check-links.sh` contra producción: **95 URLs, 0 fallos · 26 posts del sitemap, 0 huérfanos**.
- JSON-LD: **332 bloques en 100 páginas · 0 errores**, validados offline contra el vocabulario oficial de schema.org (`schemaorg-current-https.jsonld`): todo `@type` existe, toda propiedad existe y es aplicable a su tipo siguiendo `domainIncludes` + `rdfs:subClassOf`. Se validó además una muestra por `validator.schema.org` (0 errores, 0 warnings) hasta agotar su límite de peticiones.

---

## Search Console: `Offer` sin `price` en las páginas corporativas (agosto 2026)

Search Console notificó formalmente el error ya detectado en la auditoría: el `Offer` del `Product` de las 4 landings de eventos de empresa declaraba `priceCurrency:"EUR"` sin `price`. Un `Offer` con moneda y sin importe no es válido para el rich result de precio.

**Barrido previo.** Parseados los **332 bloques JSON-LD de las 100 páginas** recorriendo el árbol completo (no un grep por fichero), buscando `Offer`/`AggregateOffer` con `priceCurrency` y sin ninguno de `price` / `lowPrice` / `highPrice` / `priceSpecification`. **Resultado: exactamente los 4 casos conocidos, ningún otro.** Los otros 36 `Offer` del sitio ya llevaban `price`.

**Decisión: opción A′ — precio visible + schema**, no solo schema. Marcar un precio que no aparece en la página incumple la política de datos estructurados de Google (el importe debe ser el que ve el usuario) y expone a acción manual, justo el riesgo que se quería cerrar. La alternativa de eliminar `offers` habría sido válida pero renunciaba al rich result de precio.

**Estado real de partida** (no era homogéneo): FR y RU **ya mostraban `1 200 €`** en el body y en su `FAQPage`; solo les faltaba el `price` en el `Offer`. ES y EN no tenían ninguna cifra en toda la página.

| Página | Cambio en el body | Cambio en el `Offer` |
|---|---|---|
| `eventos-empresa-barco-marbella` | FAQ *"¿Qué incluye el precio del evento?"* pasa a abrir con **`1.200€`** (salida privada de 2 h) | `price:"1200"` |
| `corporate-events-boat-marbella` | Sección *"What's included & options"* abre con **`€1,200`** | `price:"1200"` |
| `evenements-entreprise-bateau-marbella` | ya mostraba `1 200 €` (sin cambios) | `price:"1200"` |
| `korporativy-yakhta-marbella` | ya mostraba `1 200 €` (sin cambios) | `price:"1200"` |

El precio se redacta siempre como **suelo, no como tarifa cerrada**: el texto mantiene el ángulo "presupuesto a medida" y explicita que el importe final depende de duración, catering y extras. Formato de cifras por idioma según la regla del README. En ES el texto es idéntico en el `FAQPage` y en el HTML visible, y se editó de una sola vez para que no se desincronicen.

Dato conforme a la **regla anti-invención**: `2 h → 1.200 €` ya figura en la tabla de datos confirmados del README.

### Verificación
- JSON-LD: **332 bloques · 0 errores de parseo · 0 `Offer` con `priceCurrency` sin `price`** en todo el sitio.
- Coincidencia schema ↔ visible comprobada en las 4 páginas: `price:"1200"` + `EUR` en el `Offer`, y la cifra con el formato del locale presente en el body descontando los bloques `<script>`.

---

## Medición anónima del abandono del formulario de reserva (agosto 2026)

Objetivo: saber en qué punto se cae la gente al reservar y con qué configuración,
**sin recoger ningún dato de identidad**. Ver la guía de consulta en
[`docs/GA4-embudo-reserva.md`](docs/GA4-embudo-reserva.md).

### Qué se ha encontrado antes de tocar nada

Dos cosas que cambiaron el planteamiento inicial:

1. **El widget de la home no es el formulario de reserva.** Es un buscador de 3
   campos (fecha, duración, invitados) cuyo CTA es un `<a>` a `/reservar`: sin
   extras, sin campos de contacto y sin envío a WhatsApp. Como la navegación
   dispara `pagehide`, medirlo con el mismo esquema habría contado como abandono
   a **todo** el que sí avanza. Se le ha dado su propio evento de éxito,
   `form_continue`.
2. **Los campos de nombre, email, teléfono y peticiones no iban a ningún sitio.**
   Eran `<input>` sin `id` ni `name`, y el handler de «Solicitar reserva» montaba
   el mensaje de WhatsApp solo con duración, invitados, fecha, extras y total. El
   cliente los rellenaba y se perdían, en los 4 idiomas.

### Cambios

- **`js/form-tracking.js`** (nuevo): módulo compartido por las 8 páginas. Emite
  `form_start`, `form_progress` (con `step`), `form_continue`, `whatsapp_submit`
  y `form_abandon` (con `last_step`), con los parámetros de producto `duration`,
  `guests`, `extras_count`, `date_offset`, `form_location` y `lang`.
  `form_abandon` usa `visibilitychange`/`pagehide` con `transport_type:'beacon'`.
  **No lee jamás el `.value` de los campos de identidad**: del bloque de contacto
  solo registra que hubo interacción.
- **Datos de contacto al mensaje de WhatsApp.** Los 4 campos reciben `id` y se
  añaden al mensaje prerrellenado de `wa.me`, con etiquetas por idioma. Es el
  sitio correcto para ese dato: lo envía el propio cliente, es first-party y no
  entra en GA4.
- **Fecha por defecto en el pasado (bug).** Los 8 campos de fecha llevaban
  `value="2026-07-11"` hardcodeado — un mes por detrás de la fecha actual. Ahora
  salen **vacíos** y con `min` = hoy, fijado en tiempo de ejecución para que no
  vuelva a caducar. Se elimina de paso la lógica muerta de `DEF_DATE`.

### Verificación (local, con el transporte de GA4 interceptado)

Recorrido completo del embudo en `es`, `en`, `fr` y `ru`, en la home y en el
formulario de reserva, leyendo el payload real de `/g/collect`:

- Los 7 eventos de `/reservar` y los 5 de la home salen con sus parámetros
  correctos; `date_offset` se calcula bien (0 = hoy, 18, 139) y **se omite** si
  aún no se ha elegido fecha, para no confundirlo con «hoy».
- `form_start` una sola vez por sesión y formulario; un `form_progress` por paso
  aunque se toque el bloque varias veces; `form_abandon` **una sola vez** aun
  recibiendo dos `pagehide` y un `visibilitychange`; y suprimido si hubo éxito.
- **Prueba de fuga:** rellenados nombre, email, teléfono y notas con cadenas
  canario y buscadas en todo el tráfico saliente hacia Google Analytics
  (URL + cuerpo de los POST por lotes, codificado y descodificado).
  **Cero coincidencias.** El mensaje de WhatsApp, en cambio, sí llega completo
  con los 4 campos en los 4 idiomas.

---

## Aviso por email de cada solicitud de reserva (agosto 2026)

Hasta ahora «Solicitar reserva» solo abría WhatsApp. Quien está en un ordenador
sin WhatsApp Web se perdía. Ahora, además, llega un email a `info@` con el lead.

### `/api/lead` (nuevo)

Función serverless en Vercel. Recibe el formulario por POST y manda el correo con
**Resend**, leyendo la credencial de `process.env.RESEND_API_KEY` — nunca escrita
en el repo, nunca devuelta en una respuesta, nunca en un log. `from` usa el
dominio verificado (`reservas@rentboatmarbella.com`) y `reply_to` es el email del
cliente, para responderle sin copiar y pegar la dirección.

No hace falta `package.json` ni dependencias: el runtime de Node de Vercel ya
trae `fetch`, así que se llama a la API REST de Resend directamente.

Al ser un endpoint público sin autenticar, lleva: solo POST, tope de 8 KB de
cuerpo, tope de longitud por campo, limpieza de caracteres de control (evita
cabeceras fabricadas), escapado HTML de todo lo que escribe el usuario y un
limitador de 10 peticiones/minuto por IP. El limitador es *best-effort*: la
memoria muere con la instancia y Vercel levanta varias, así que frena un bucle
accidental, no un ataque decidido.

**El correo solo se manda si hay email o teléfono.** Sin ninguno de los dos no
habría a quién responder, y el cliente no se pierde porque WhatsApp se le abre
igual.

### En los 4 formularios

La llamada va **antes** de `window.open`, con `fetch(..., {keepalive:true})`,
envuelta en `try` y con `.catch()` vacío. Es fire-and-forget: no se espera
respuesta, no se comprueba el resultado y ningún fallo puede impedir que se abra
WhatsApp. El mensaje de WhatsApp y la medición GA4 del PR #12 quedan intactos.

### Corregido de paso: `js/form-tracking.js` era incacheable de por vida

La regla `/(.*)\.(css|js|woff2|woff|ttf)` de `vercel.json` sirve los `.js` con
`max-age=31536000, immutable`. Con un nombre sin versionar, el tracker que subimos
en el PR #12 **nunca** se habría refrescado en un navegador que ya lo tuviera.
Ahora se carga como `/js/form-tracking.js?v=1` en las 8 páginas. **Al editar ese
fichero hay que subir el número**, o el cambio no llegará a los visitantes que
repiten.

### Verificación

- `scripts/test-lead-api.js` (nuevo, `node scripts/test-lead-api.js`): 21
  comprobaciones con Resend simulado, sin red ni credenciales. Cubren el asunto,
  los 11 campos del cuerpo, destinatario y `reply_to`, las guardas (405/400/413/
  422/500/502), que la credencial no viaja nunca a la respuesta, el escapado de
  `<img onerror>`, la limpieza de `\r\n` en el teléfono y el limitador por IP.
- En navegador, en los 4 idiomas: **WhatsApp se abre igual** con `/api/lead`
  devolviendo 404 y con `fetch` lanzando una excepción síncrona; la llamada sale
  con `keepalive:true`; y sin email ni teléfono no se llama a la API.

---

## Datos de contacto obligatorios y selector de prefijo internacional (agosto 2026)

Los tres campos de contacto eran opcionales y no se validaban: se podía enviar
la solicitud con «test» en email y teléfono. El lead llegaba sin forma de
contactar y, cuando el teléfono venía sin prefijo, tampoco se sabía a qué país
llamar. Además `/api/lead` descarta el aviso si no hay email **ni** teléfono, así
que esos envíos no generaban correo.

### Obligatorios y validados (los 4 formularios, los 4 idiomas)

Nombre, email y teléfono son ahora obligatorios (`aria-required`, asterisco en el
campo). El botón **no envía nada** si alguno falla: ni `whatsapp_submit`, ni
`/api/lead`, ni la apertura de WhatsApp. El error sale bajo el campo que falla,
en el idioma de la página, y el primer campo inválido recibe el foco.

- **Email**: `@` + dominio con TLD. Rechaza `test`, `test@`, `test@dominio`.
- **Teléfono**: mínimo 6 dígitos y solo dígitos, espacios y `().-`.
- **Nombre**: mínimo 2 caracteres, con al menos una letra (latina o cirílica).

Tras el primer intento fallido, cada campo se revalida mientras se escribe.

### Selector de prefijo, sin librerías

Nada de `intl-tel-input` ni imágenes de banderas. 54 países viajan en **una sola
cadena** `"ISO,prefijo,nombre|…"` dentro del propio HTML y la bandera se deriva
del ISO con los símbolos regionales Unicode: es texto, no pesa y no añade ni una
petición. La lista se construye en el DOM la **primera vez que se abre** el
desplegable, no en la carga.

- Buscable escribiendo el nombre del país (sin tildes también: «espan» → España),
  el código ISO o el propio prefijo. Teclado completo: ↑ ↓, Enter, Esc.
- Nombres de país **en el idioma de la página** y ordenados alfabéticamente en
  ese idioma (ES Alemania · EN Germany · FR Allemagne · RU Германия).
- Prefijo por defecto según idioma: ES +34 · EN +44 · FR +33 · RU +7.
- Si el usuario pega el número en formato internacional (`+33 6…`, `0044 7…`), el
  prefijo se mueve al selector en vez de duplicarse en el mensaje.

El teléfono sale **completo (prefijo + número)** tanto en el mensaje de WhatsApp
como en el POST a `/api/lead`.

### Corregido de paso: el email quedaba en 54 px en móvil

La rejilla de contacto usaba `grid-template-columns` en el `style` y mobile.css
la forzaba a una columna con `!important`; como dos hijos llevaban
`grid-column:span 2`, el navegador creaba una columna implícita y el campo de
email se quedaba en 54 px de ancho. Ahora la rejilla tiene clase propia
(`.bk-fields` / `.bk-full`) con su media query, y en móvil los campos van uno
debajo de otro a ancho completo.

### Coste en rendimiento

Prioridad absoluta, siendo un sitio con 88–99 en PageSpeed:

- **+3,8 KB gzip** por página de reserva (8,7 → 12,6 KB el documento), **cero
  peticiones nuevas** y ningún recurso bloqueante añadido: todo va en el `<script>`
  que ya existía al final del `<body>`.
- Construir la lista al abrirla: **~8 ms** (Chrome, CPU ×4). Filtrar: **0,05 ms**
  por tecla. Cero *long tasks* en la carga. CLS 0,00 antes y después.
- Lighthouse móvil (mismo servidor local, antes vs después): accesibilidad
  **96 → 96**, buenas prácticas **100 → 100**, SEO **100 → 100**. El único fallo
  de accesibilidad es el contraste del footer, que ya existía.

### Verificación

- `scripts/test-booking-form.js` (nuevo, `node scripts/test-booking-form.js`):
  304 comprobaciones sobre los 4 HTML. Ejecuta **las reglas de validación reales**
  extraídas del propio fichero servido (marcadores `[RBM-VALIDATION-*]`) y
  comprueba el marcado, la lista de países (ISO, prefijos, idioma, orden, sin
  duplicados), el prefijo por defecto de cada idioma, que `validate()` va antes de
  `track.success()` / `/api/lead` / `window.open`, y que a GA4 no viaja ningún
  valor tecleado.
- En navegador, en los 4 idiomas: envío bloqueado con «test» (0 aperturas de
  WhatsApp, 0 llamadas a la API, sin `whatsapp_submit`), filtrado del selector en
  cada idioma, prefijo por defecto correcto y teléfono completo llegando al
  mensaje de WhatsApp y al cuerpo del POST.

---

## Programa multiidioma: Fase 0 + Oleada IT, Entrega 1 (19 de agosto de 2026)

El sitio pasa de 4 a 8 idiomas (**IT, NL, DE, AR**) en oleadas: cada una se cierra
entera antes de abrir la siguiente y se reparte en tres entregas (core → landings
+ formulario propio → blog). Esta tanda cubre la infraestructura común y la
Entrega 1 del italiano. Convenciones y redacciones canónicas: `README.md` →
«Idiomas del programa multiidioma».

### Fase 0 — infraestructura

**Selector de idioma: desplegable también en escritorio.** Con ocho idiomas la
fila en línea deja de caber en el header, así que el patrón *disclosure* que el
PR #15 dejó solo en ≤760px pasa a ser el único modo.

- `mobile.css`: el bloque del desplegable sale de la media query de 760px y pasa
  a ser global; en móvil solo queda el ajuste del área táctil (botón 38px, filas
  44px, WCAG 2.5.5). El panel se ancla con **`inset-inline-end`** en vez de
  `left` —así el árabe no necesitará una regla aparte—, mide 174px, muestra
  código + endónimo y lleva `max-height:min(70vh,420px)` con scroll propio,
  porque ocho filas no caben en un móvil apaisado.
- Botón de **34px de alto en escritorio**, por debajo de los 35px del CTA
  «Reservar»: medido en navegador, el header sigue en **69px** (escritorio) y
  **91px** (móvil), los mismos de antes. Sin CLS y sin tocar `[data-nav-spacer]`.
- `js/lang-switcher.js`: fuera el `matchMedia('(max-width: 760px)')` que cerraba
  el panel al pasar a escritorio, porque ahí ya no había panel; ahora se cierra
  al redimensionar. El resto (foco al primer idioma distinto del actual, `Escape`,
  clic fuera, `focusout`, `syncSpacer`) intacto.
- **Sin JavaScript**, comportamiento de siempre: los idiomas quedan en línea, el
  botón no se pinta y el endónimo va oculto, así que solo se ven los códigos de
  dos letras (~236px para ocho). Verificado en navegador.
- `apply-lang-switcher.py`: 8 idiomas en `ORDER`/`CODE`/`ENDONYM`/`HOME`/
  `BTN_LABEL`, conjunto `RTL = {'ar'}` y `dir="rtl"` en el enlace al árabe desde
  cualquier página LTR. El *fallback* a portadas de idioma para páginas sin
  alternates ahora solo ofrece las portadas **que existen**, para no crear
  enlaces rotos hacia oleadas sin abrir.
- **La versión de los assets immutables se declara en un solo sitio.** Antes el
  `?v=` estaba escrito a mano en cada página y el script solo sabía añadirlo si
  faltaba; ahora `CSS_V`/`JS_V` en `apply-lang-switcher.py` se propagan por regex
  a las 135 páginas. `mobile.css?v=2 → ?v=3`, `lang-switcher.js?v=1 → ?v=2`.
- `check-lang-switcher.py`: valida los 8 idiomas y que el `dir="rtl"` esté
  exactamente en los idiomas RTL y en ningún otro. 561 enlaces comprobados.

### Oleada IT — Entrega 1 (5 páginas)

| Slug | Title | Long. | Meta desc. |
|---|---|---|---|
| `/it` | Noleggio Barca a Marbella \| Yacht Privato da 1.200 € | 52 | 148 |
| `/flotta-barche-marbella` | La Nostra Flotta a Marbella \| De Antonio D50 di 15 Metri | 56 | 155 |
| `/escursioni-barca-marbella` | Escursioni in Barca a Marbella \| Esperienze in Yacht | 52 | 151 |
| `/proposta-matrimonio-barca-marbella` | Proposta di Matrimonio in Barca a Marbella \| Yacht Privato | 58 | 145 |
| `/foto-matrimonio-barca-marbella` | Foto di Matrimonio in Barca a Marbella \| Servizio in Yacht | 58 | 151 |

**Localización, no traducción.** El lector italiano llega con dos modelos en la
cabeza —el gommone a noleggio por horas, con o sin patente, o el *posto* en una
gita collettiva— y la home ataca justo esa diferencia: la barca entera para tu
grupo, skipper siempre a bordo (ninguna patente, tampoco la italiana), tarifa
per la barca intera e non a testa. Se apoya con el dato de aeropuerto ya
verificado en el sitio (Málaga, ~65 km, 45-60 min). La landing de propuesta usa
la discreción de proponer fuera de casa; la de fotos, que un *servizio
fotografico* que en Italia pediría permisos y una playa disputada en agosto aquí
son dos horas y un solo desplazamiento.

- **5 grupos `hreflang` de 4 a 5 miembros**, con los 25 miembros reescritos
  (home, flota, actividades, pedida, bodas). `x-default` sigue en ES en los cinco.
  Ningún otro grupo del sitio tocado.
- **JSON-LD** con el mismo patrón de bloques que el equivalente ES y
  `inLanguage: it` donde el ES lo lleva. Total del sitio: **468 bloques**
  (452 + 16), validados offline contra el vocabulario schema.org: **0 errores**.
- **Markup idéntico al español**, no reescrito: `mobile.css` selecciona por
  subcadenas del `style` inline (`div[style*="grid-template-columns:repeat(4"]`…),
  así que cualquier deriva rompería el responsive en silencio. Donde la Entrega 1
  solo tiene 2 landings en vez de 9, la rejilla usa `1fr 1fr` —que colapsa a una
  columna en móvil— en vez de `repeat(2,1fr)`, que en este CSS se queda en dos.
- **Nav sin «Blog»** hasta la Entrega 3: no se manda a un lector italiano al blog
  inglés desde su propio menú. El hub de experiencias lista las 2 landings
  italianas como cards y las otras 6 ocasiones como texto sin enlace, en vez de
  enlazarlas en otro idioma.
- **Footer**: legales **EN** con `hreflang="en"` y un `(in inglese)` visible.
- **CTA de reserva → `/booking` (EN)** hasta la Entrega 2. `form-tracking.js` no
  necesitó cambios: saca `lang` de `<html lang>`, así que el embudo GA4 separa el
  italiano solo.
- **Sitemap 130 → 135.**

### Deuda ajena que destapó el grep anti-invención

El grep pasa a ser script (`scripts/check-datos-comerciales.sh`), con patrones
por idioma y por claim, y con los comentarios HTML excluidos. Encontró **13
páginas publicadas** que la limpieza del 19/08 no había alcanzado — **35
sustituciones**:

- **Equipo de sonido a bordo** en HTML visible *y* en el `FAQPage`:
  `despedida-soltero-barco-marbella` (ES), `cumpleanos-en-barco-marbella` (ES),
  `hen-party-yacht-marbella` y `bachelor-party-yacht-marbella` (EN),
  `birthday-boat-marbella` (EN), `anniversaire-yacht-marbella` (FR),
  `devichnik-yakhta-marbella`, `malchishnik-yakhta-marbella` y
  `sunset-tour-yakhta-marbella` (RU). También el extra «upgraded speaker set-up»,
  que daba por hecho que hay un equipo base.
- **Subir bebida propia** (no hay política de descorche): `hen-party-yacht-marbella`
  (EN), `anniversaire-yacht-marbella` (FR) y `despedida-soltero-barco-marbella` (ES).
- **Colchoneta flotante** (el único equipo de agua es el paddle surf) en cuatro
  posts EN/FR/RU, y una botella «fría» para brindar en `birthday-boat-marbella`.

Y dos regresiones antiguas más, del mismo tipo:

- **Tabla de quesos en la card de sunset** de las 4 páginas de actividades. Las 4
  landings de sunset se corrigieron el 19/08; esta card, no. Sustituida por la
  enumeración canónica de cada idioma.
- **`2× M` truncado** en la tarjeta de motores de las **4 portadas**. El PR #10
  arregló la de las fichas de flota y dio el caso por cerrado. Ahora muestra la
  potencia total con la motorización debajo, en el formato de cada idioma
  (`1.200 CV` · `1,200 hp` · `1 200 ch` · `1 200 л.с.`).

`scripts/check-datos-comerciales.sh` queda a **0 hits** en las 135 páginas.

### Verificación

- `scripts/check-links.sh` contra un servidor local **con `cleanUrls`** (handler
  que prueba `<ruta>.html`; el `python3 -m http.server` pelado no lo replica y
  daba 404 en todos los `/post/`): 125 URLs, **0 fallos**; 56 posts del sitemap,
  **0 huérfanos**.
- Barrido offline propio: **2.986 enlaces internos distintos** de las 135 páginas
  resuelven a un fichero, las 135 URLs del sitemap existen y ninguna página del
  repo queda fuera del sitemap. Hacía falta porque `check-links.sh` solo recorre
  lo enlazado desde los índices de blog, y las 5 páginas italianas aún no lo están.
- `scripts/check-lang-switcher.py`: 135 páginas, 561 enlaces, **0 problemas**.
- `scripts/check-offer-price.sh`: 4 páginas corporativas, **0 problemas**.
- JSON-LD offline: 468 bloques, `@context` correcto y tipos del vocabulario
  schema.org, **0 errores**.
- Navegador (Chrome DevTools, servidor local): desplegable a **1440px** y a
  **390px** (emulación de móvil con DPR 3), alto del header y del *spacer*
  coincidentes (69/69 y 91/91), panel sin desbordar por ningún lado, 44px de alto
  por fila en móvil, y modo degradado sin JS con los idiomas en línea.

---

## Oleada IT — Entrega 2: landings de ocasión, formulario propio y recableado (19 de agosto de 2026)

Nueve páginas nuevas en italiano y el recableado de las cinco de la Entrega 1.
Con esto el italiano tiene **14 páginas**: todo el sitio menos el blog, que es la
Entrega 3. Reglas y redacciones canónicas, en `README.md`.

### Alcance: cómo se fijó la lista

La lista definitiva salió del **conjunto de landings que ya existen en los idiomas
publicados**, no de una enumeración a ojo. Dos decisiones que conviene dejar
escritas porque no son obvias:

- **Entra la comparativa aunque su grupo solo tuviera 2 miembros.**
  `barco-privado-vs-plataformas` existe en ES y EN, no en FR ni RU. Aun así se
  localiza: es la página «por qué reservar directo», va enlazada desde el footer
  y es exactamente el argumento que necesita un mercado nuevo, donde el lector no
  conoce la marca. Su grupo `hreflang` pasa de **2 a 3**.
- **Queda fuera el «boat party».** No existe como landing en **ningún** idioma:
  es un post de blog en los cuatro (`/post/boat-party-puerto-banus`,
  `/post/fiesta-en-barco-puerto-banus`, `/post/soiree-bateau-puerto-banus`,
  `/post/vecherinka-na-yakhte-puerto-banus`). Crear una landing italiana sin
  equivalente en ningún otro idioma sería arquitectura nueva, no localización, y
  dejaría un grupo `hreflang` de un solo miembro. Va con la Entrega 3.

### Las 9 páginas

| Slug IT | `title` | len | `meta` | Precio | Grupo |
|---|---|---|---|---|---|
| `addio-al-celibato-barca-marbella` | Addio al Celibato in Barca a Marbella \| da 1.800 € | 50 | 149 | 1.800 € | 4→5 |
| `addio-al-nubilato-barca-marbella` | Addio al Nubilato in Barca a Marbella \| da 1.800 € | 50 | 148 | 1.800 € | 4→5 |
| `compleanno-in-barca-marbella` | Compleanno in Barca a Marbella \| Festa Privata da 1.200 € | 57 | 147 | 1.200 € | 4→5 |
| `sunset-tour-barca-marbella` | Sunset Tour in Barca a Marbella \| Tramonto da 1.200 € | 53 | 146 | 1.200 € | 4→5 |
| `avvistamento-delfini-marbella` | Avvistamento Delfini a Marbella \| Uscita Privata in Barca | 57 | 154 | 1.800 € | 4→5 |
| `escursione-barca-gibilterra-marbella` | Escursione in Barca a Gibilterra da Marbella \| Yacht Privato | 60 | 141 | 3.000 € + carburante | 4→5 |
| `eventi-aziendali-barca-marbella` | Eventi Aziendali in Barca a Marbella \| Yacht Privato | 52 | 152 | 1.200 € | 4→5 |
| `barca-privata-vs-piattaforme` | Barca Privata o Piattaforme di Noleggio a Marbella | 50 | 154 | — | 2→3 |
| `prenota` | Prenota una Barca a Marbella \| Prezzi e Disponibilità | 53 | 146 | — | 4→5 |

Todos los `title` ≤60 y todas las `meta` en 140–155. La cifra va en el `title`
donde de verdad aporta CTR (las cuatro landings con precio de entrada claro); en
las de delfines, Gibraltar y eventos manda el formato de la salida, que es lo que
diferencia la búsqueda.

### Slugs

Siguen la convención del README (`<keyword>-barca-marbella`, sin diacríticos) con
dos excepciones razonadas, ambas heredadas del patrón de los demás idiomas:
`avvistamento-delfini-marbella` no lleva el token de la barca —igual que
`avistamiento-delfines-marbella` y `dolphin-watching-marbella`—, y
`barca-privata-vs-piattaforme` sigue la forma de comparativa de ES y EN.
`escursione-barca-gibilterra-marbella` usa el topónimo italiano (*Gibilterra*),
que es como se busca desde Italia.

### Localización, no traducción

El gancho de cada landing parte de con qué compara el lector italiano:

- **Addio al celibato / al nubilato:** contra la serata in discoteca (lista
  all'ingresso, consumazione minima, tavolo diviso) y contra el *posto* comprado
  en una gita collettiva. El argumento es la **barca intera** y la tariffa **per
  imbarcazione, non a testa**.
- **Compleanno:** contra la cena per dieci al ristorante — mismo gasto, dura todo
  el día y no termina con la cuenta.
- **Sunset tour:** contra la gita al tramonto a posto singolo; aquí la barca no
  vuelve a puerto porque lo diga el horario del tour.
- **Avvistamento delfini:** el eje es la honestidad — **no se garantiza el
  avistamiento**, se dice en el primer bloque y en la FAQ, y se explica la regla
  de no perseguir ni cortar la rota a los animales.
- **Gibilterra:** el carburante adicional se anuncia **arriba**, no al final, y se
  dice que el desembarco no está incluido porque es paso fronterizo.
- **Eventi aziendali:** el argumento italiano es la **fattura con IVA** a nombre
  de la sociedad y el presupuesto cerrado antes de salir.
- **Comparativa:** contra el **gommone a noleggio senza patente**, que es la
  fórmula que un italiano tiene en la cabeza, y con la tabla de 5 filas del
  original.

En las siete landings de ocasión: `Product + BreadcrumbList + LocalBusiness +
FAQPage`, el mismo patrón que sus equivalentes ES. La comparativa lleva
`BlogPosting + BreadcrumbList + FAQPage + LocalBusiness` con `inLanguage:"it"`,
como su original. **Los `Offer` italianos llevan `url`**, que es justo lo que
falta en los cuatro corporativos del backlog (§3.2 de `ESTADO.md`).

### El formulario `/prenota`

**No se escribió desde cero: se transformó `booking.html`** con 73 sustituciones
literales, cada una afirmada con su número de ocurrencias esperadas. Si el
original cambia, el generador falla en vez de producir una página a medias. Así
el formulario italiano hereda **exactamente** la lógica ya probada: validación,
absorción de prefijo pegado, orden de disparo (validar → `track.success` →
`/api/lead` → WhatsApp), y la propiedad de que GA4 no lee ningún `.value` tecleado.

Lo propio del italiano:

- **`CFG`** — formato `1.200 €` (separador `.`, sufijo ` €`), `Su preventivo` para
  la opción a medida, `durSum` (`2 ore`, `4 ore`, `Giornata 8h`, `Su misura`) y el
  mensaje de WhatsApp entero.
- **`CC`** — los tres pares de mensajes de error, `def:"IT"` y el botón que ya
  pinta `+39` en el HTML servido, sin esperar al JS.
- **Los 54 prefijos traducidos y reordenados** por colación italiana (*Cechia*
  entre Canada y Cipro, *Paesi Bassi* en la P, *Regno Unito* en la R, *Stati
  Uniti* en la S). El test lo comprueba con `localeCompare(nombre, 'it')`.

`js/form-tracking.js` no necesitó ni una línea: saca `lang` de `<html lang>`, así
que el embudo de GA4 y el aviso por email separan el italiano solos —verificado
en el payload real, que sale con `lang:"it"` y `page:"/prenota"`.

`scripts/test-booking-form.js` gana el quinto formulario en su array `PAGES`:
**380 comprobaciones** (eran 304), todas en verde.

### Recableado, hub y footer

- **27 CTA** de las 5 páginas de la Entrega 1 pasan de `/booking` (EN) a
  `/prenota`. El README decía 22: era el recuento de una versión anterior de esas
  páginas. Antes de sustituir se comprueba que ningún `/booking` esté **dentro del
  selector de idioma**, donde sí debe seguir apuntando al inglés.
- **El hub `/escursioni-barca-marbella`**: las **6 ocasiones que eran texto sin
  enlace** ahora enlazan a sus landings, y la rejilla crece a **8** con eventos de
  empresa y la comparativa. Cada tarjeta pasa de `<div>` a `<a>` con su
  «Scopri di più →».
- **El footer italiano** de las 14 páginas: la columna «Esperienze» pasa de 2 a
  **8** enlaces, «Info» gana «Perché prenotare diretto». **Sigue sin «Blog»**: la
  Entrega 3 lo añadirá. Las legales siguen apuntando a las **EN** con
  `hreflang="en"` y el `(in inglese)` visible.

### Dato comercial nuevo: atención en italiano

El propietario confirmó el 19/08/2026 que **se atiende por WhatsApp y email en
italiano**. Es el argumento de conversión que le faltaba a un mercado nuevo, y se
publica **solo en las páginas IT**, con la redacción canónica del README
(`Assistenza in italiano su WhatsApp ed e-mail`), donde convierte: junto a los CTA
de la home (buscador del hero y CTA final), en el párrafo de entrada y en la
tarjeta lateral de las 8 landings, en la tarjeta de resumen de `/prenota`, en el
CTA de la flota y del hub, y en la columna «Contatti» del footer.

**Lo que no se dice, y es deliberado:** que el patrón hable italiano. El patrón
habla **ES · EN · FR · RU** y así sigue en todas las páginas. En la comparativa
—la única donde conviven los dos datos— van en párrafos separados y en ese orden:
primero qué habla el patrón a bordo, después que la asistencia escrita es en
italiano.

### Deuda ajena corregida de paso: la música a bordo

Localizar destapó una clase de claim que el grep no cubría. El propietario
confirmó el 19/08 que **no hay equipo de sonido a bordo**, y sin embargo:

- La landing **ES de despedida de soltero** —fuente directa de la italiana—
  ofrecía «barra premium con **DJ y altavoz portátil**» y «catering ampliado con
  marisco y **bebida fría**» (tampoco hay nevera), en HTML visible **y** en el
  `FAQPage`. **6 sustituciones**, editando los dos a la vez para que no se
  desincronicen.
- **12 páginas de los 4 idiomas** prometían literalmente «Música a bordo / Music
  on board / Musique à bord / Музыка на борту»: los 4 hubs de experiencias (card
  de despedida de soltera), las 4 landings de cumpleaños y las pastillas del hero
  de las 4 de despedida de soltera. **12 sustituciones**, cambiando la promesa por
  algo confirmado (paddle surf, snorkel, 100% privado).
- La **`meta description`** de 6 de esas páginas lo llevaba a la ficha del
  buscador, con 3 copias por página (`meta`, `og:`, `twitter:`). **18
  sustituciones**, todas dentro del rango de longitud que ya tenían.

**36 sustituciones en total.** `check-datos-comerciales.sh` gana dos cosas: un
patrón **duro** por idioma para el equipo que tendría que poner la casa (altavoz,
barra premium, DJ, bebida fría) y una lista **blanda** de revisión para «música a
bordo», que ya queda a 0 y no rompe el build.

**Lo que no se ha tocado**, y conviene que se sepa: quedan **~120 menciones de
«música» de otro tipo** («ponéis vuestra música», «coordinamos la playlist»,
«Musique douce diffusée à bord», las secciones «Música y baile» de las landings de
despedida) en ~45 páginas de los 4 idiomas. Son zona gris y dependen de **una sola
pregunta al propietario**: si el cliente puede subir su propio altavoz. Reescribir
45 páginas antes de tener esa respuesta es reescribirlas dos veces. Queda anotado
en `ESTADO.md` §3.13 y §5.14.

### Verificación

- **`scripts/check-links.sh`** contra un servidor local con `cleanUrls`: 125 URLs,
  **0 fallos**; 56 posts del sitemap, **0 huérfanos**.
- **Barrido local propio**: las **144** URLs internas distintas enlazadas desde
  cualquier página del repo, más todas las del sitemap, responden **200**. Hacía
  falta porque `check-links.sh` solo recorre lo enlazado desde los índices de blog
  y las páginas italianas no aparecen ahí hasta la Entrega 3.
- **Reciprocidad `hreflang`** en las 144 páginas: **0 incoherencias**. Cada grupo
  ampliado se reescribió entero —**34 páginas existentes**, no solo las nuevas— y
  el `x-default` sigue apuntando al español en los nueve.
- **`scripts/check-lang-switcher.py`**: 144 páginas, **638** enlaces de idioma, 0
  problemas.
- **`scripts/check-datos-comerciales.sh`**: **0 hits** de claims prohibidos.
- **`node scripts/test-booking-form.js`**: **380** comprobaciones sobre 5
  formularios, 0 fallos.
- **`node scripts/test-lead-api.js`**: 21 comprobaciones, 0 fallos.
- **`scripts/check-offer-price.sh`**: **5** páginas corporativas (con la italiana),
  0 problemas.
- **JSON-LD offline**: **501** bloques (eran 468), todos parseables; **FAQ del
  `<head>` idéntica a la visible** en las 9 páginas nuevas y en la ES corregida.
- **Navegador (servidor local, `window.open` y `fetch` interceptados —ningún lead
  real)**: sin datos válidos el submit no dispara nada; los tres errores salen en
  italiano; con datos válidos el mensaje de WhatsApp sale entero y bien formateado
  (`4 ore (1.800 €)`, `Totale stimato: 2.050 €`); `/api/lead` recibe `lang:"it"`;
  un `+34 600111222` pegado se mueve solo al selector y el campo queda en
  `600111222`; el buscador de países filtra por «germ» → *Germania +49*. En una
  landing: header a **69px** (sin CLS), panel del selector con sus 5 idiomas a
  40px por fila, sin scroll horizontal y **0 errores de consola**.
- **Sitemap**: 135 → **144** URLs, XML bien formado.
- **`mobile.css` y `js/` sin tocar**, así que no hubo bump de `CSS_V`/`JS_V`.
