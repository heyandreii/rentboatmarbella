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

## Backlog SEO (mejoras futuras)

- **[PRIORITARIO] Traducir a FR y RU los 4 posts del blog que hoy solo existen en ES:** `mejores-calas-fondear-marbella`, `alquilar-barco-marbella-invierno`, `despedida-soltera-barco-consejos` y `pedida-matrimonio-en-el-mar`. **Máxima prioridad: "mejores calas"** (es la pieza pilar). Mientras no existan, los índices `/blog-nautique` (FR) y `/morskoy-blog` (RU) solo muestran su post de precios propio (se eliminaron las cards que enlazaban a los posts ES para no mezclar idiomas). Al traducirlos, volver a añadir sus cards a los índices FR/RU.
- ~~Ampliar el resto de landings FR/RU a 600–900 palabras~~ ✅ **hecho** (las 14 landings FR/RU ampliadas).
- **AVIF** y `srcset`/`sizes` multi-ancho (la conversión a WebP ya captura el mayor ahorro).
- Ejecutar **Lighthouse** tras el deploy en Vercel y comparar (baseline no capturada por falta de entorno servido; mejora esperada alta por la reducción de imágenes).

## Tareas manuales de marketing (del plan original)

- Completar/reclamar Google Business Profile con fotos reales del De Antonio D50.
- Pedir reseñas de Google a cada cliente.
- Verificar propiedad en Google Search Console y enviar el sitemap.
- Alta en directorios náuticos/turismo Costa del Sol; conserjerías de hoteles de la Milla de Oro.
- Vigilar la confusión de marca con *rentalboatmarbella.com* (competidor de nombre casi idéntico).
