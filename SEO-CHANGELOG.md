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
