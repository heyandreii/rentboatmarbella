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
- **Sitemap:** +8 URLs (94 en total). Nav/footer/breadcrumb 100 % en el idioma de la página; logo y
  breadcrumb «Accueil»/«Главная» apuntan a `/fr` y `/ru` (no a la home ES).

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
