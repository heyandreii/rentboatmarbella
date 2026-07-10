# Plan de acción SEO — rentboatmarbella.com

> **Instrucciones para Claude Code:** este documento es la lista de tareas derivada de una auditoría SEO (julio 2026). Ejecuta las tareas en orden de fase. Antes de empezar, detecta el stack del repo (framework, generador estático, estructura de rutas, sistema de i18n) y adapta la implementación a él. Marca cada tarea con `[x]` al completarla y haz un commit por tarea o grupo lógico de tareas con mensajes descriptivos (`fix(seo): ...`, `feat(blog): ...`). No cambies diseño ni textos comerciales salvo donde se indique.

---

## Contexto del negocio (para redactar contenido)

- Empresa de alquiler de **un único barco premium: De Antonio D50**, con patrón incluido, salidas desde **Puerto Banús / Marbella**.
- Posicionamiento: **chárter 100% privado** (nunca compartido), todo incluido, patrón multilingüe (ES/EN/FR/RU), reembolso si el mar impide salir.
- Precios orientativos: desde ~1.200 € (2 h) hasta ~3.000 € (día completo). **Premium**: no competir en precio, competir en exclusividad.
- Idiomas del sitio: **ES (principal), EN, FR, RU** con URLs traducidas.
- Experiencias/landings existentes: sunset tour, despedidas de soltero/a, avistamiento de delfines, excursión a Gibraltar, cumpleaños, pedidas de matrimonio, eventos de empresa.
- Competencia: marketplaces (Click&Boat, SamBoat, Nautal) y operadores locales (Marbella Boat Charter, Nautica Marbella, La Dama María). **Ojo:** existe un competidor distinto llamado *rentalboatmarbella.com* (con "rental") — reforzar señales de marca propias.

---

## FASE 0 — Diagnóstico previo (hacer primero, no saltar)

- [x] **0.1** Stack identificado: **HTML estático puro** (sin framework/build) en **Vercel** (`cleanUrls:true`, `trailingSlash:false`). 58 páginas `.html`, i18n por URLs traducidas ES/EN/FR/RU, estilos inline + `mobile.css`.
- [x] **0.2** Crawl estático hecho: se listaron todas las rutas (`.html`) y se compararon con los enlaces del blog → detectados 7 posts `/post/...` en 404.
- [x] **0.3** Verificado: `robots.txt` ✅, `sitemap.xml` ✅ (65 URLs), `hreflang` ✅ (58 páginas, recíproco + x-default), JSON-LD ✅ (FAQPage×4, LocalBusiness×8, Product×40, Offer×44). Faltan: páginas Términos/Cookies y teléfono +34.
- [ ] **0.4** Lighthouse: *pendiente* — requiere el sitio servido/desplegado; se capturará baseline y comparación en la Fase 5.

---

## FASE 1 — Crítico: reparar los 404 del blog

El índice del blog (`/blog-nautico-marbella`) enlaza a 5 posts bajo `/post/...` que devuelven **404**. Es la fuga SEO más grave del sitio.

- [x] **1.1** Causa determinada: los posts **no existían** (no había carpeta `post/`); las URLs del índice eran correctas. Creada la carpeta `post/` con los archivos que Vercel sirve como `/post/...` gracias a `cleanUrls`.
- [x] **1.2** Creados y publicados los 5 posts ES (900–1.400 palabras, español, tono cercano/experto):
  - [x] `¿Cuánto cuesta alquilar un barco en Marbella? Precios 2026` — tabla de precios, qué incluye, comparativa honesta con marketplaces, factores de precio, CTA a reserva.
  - [x] `Mejores calas para fondear entre Puerto Banús y Cabopino` (1.232 palabras) — 7 calas, fondeo y mejor momento; enlaza sunset y delfines.
  - [x] `Alquilar un barco en Marbella en invierno: buena idea` (902) — clima Costa del Sol, ventajas temporada baja, precios.
  - [x] `Despedida de soltera en barco en Marbella: cómo organizarla` (1.032) — enlaza a la landing de despedidas.
  - [x] `Pedida de matrimonio en barco: ideas para que sea perfecta` (1.057) — enlaza a la landing de pedidas.
  - [x] *(extra, cierre de 404 FR/RU)* `combien-coute-location-bateau-marbella` (FR) y `skolko-stoit-arenda-yakhty-marbella` (RU), versiones localizadas del post de precios.
- [x] **1.3** Cada post: title ≤ 60 con keyword, meta description 150–160 con CTA, un solo H1, jerarquía H2/H3, keyword en las primeras 100 palabras, 2–4 enlaces internos a landings + 1 a `/reservar`. Añadido JSON-LD BlogPosting + BreadcrumbList + FAQPage en cada uno.
- [x] **1.4** Crawl completo: **cero 404 internos** en todo el sitio.
- [x] **1.5** Redirecciones 301 de URLs antiguas `/post-*.dc(.html)` → `/post/*` ya presentes en `_redirects` y `vercel.json`. No hay otras rutas antiguas conocidas.

## FASE 2 — Quick wins técnicos

- [x] **2.1 Schema FAQPage** — ya presente en las 4 homes (ES/EN/FR/RU). JSON-LD válido (parseado sin errores).
- [x] **2.2 Schema LocalBusiness** — inyectado/mejorado en **las 69 páginas**: `additionalType` BoatRental, `areaServed` (Marbella / Puerto Banús / Costa del Sol), `priceRange:"€€€€"`, `sameAs` (Instagram), dirección Puerto Banús 29660 + geo. *(Amarre exacto y URL de Google Business = TODO propietario.)*
- [x] **2.3 Schema Product/Offer** — ya presente en todas las landings de experiencia (nombre, precio, moneda).
- [x] **2.4 Páginas legales** — creadas **Términos y Condiciones** (`/terminos-condiciones`, `/terms-conditions`) y **Política de Cookies** (`/politica-cookies`, `/cookies-policy`) en ES+EN (patrón bilingüe del sitio) y enlazadas en el footer de los 4 idiomas. Datos fiscales marcados `[Razón social]`/`[NIF]` como TODO propietario.
- [x] **2.5 Teléfono** — añadido comentario-hueco `TODO: +34` junto al +33 en el footer de las 69 páginas (número real pendiente del propietario).
- [x] **2.6 Formato de cifras** — EN unificado a `€1,200 / €1,800 / €3,000`; FR y RU a `1 200 € / 1 800 € / 3 000 €`; ES intacto (`1.200€`).
- [x] **2.7 Selectores de reserva** — verificado: duración ya ordenada 2 h → 4 h → 8 h → a medida en las 4 páginas de reserva; invitados con stepper 1→máx. Sin cambios necesarios.
- [x] **2.8 robots.txt y sitemap.xml** — robots.txt referencia el sitemap; sitemap actualizado a **69 URLs** (añadidas las 4 legales), **cero URLs rotas**. *(Sitio estático: el sitemap se mantiene como archivo, no hay build.)*
- [x] **2.9 hreflang** — ya presente y recíproco ES/EN/FR/RU + `x-default` en todas las páginas; las nuevas legales y posts incluyen sus alternates.

## FASE 3 — Contenido de las landings de experiencia

Ampliar cada landing (sunset, despedidas, delfines, Gibraltar, cumpleaños, pedidas, eventos de empresa) de ~250 a **600–900 palabras**, manteniendo el diseño actual:

- [x] **3.1** Ampliadas a 600–900 palabras las **9 landings de experiencia ES** (sunset, despedida soltera, despedida soltero, delfines, Gibraltar, cumpleaños, pedida, eventos de empresa, fotos de boda): intro con keyword en primeras 100 palabras → qué incluye → ruta/qué se ve → para quién → mini-FAQ (3–4 preguntas con **FAQPage** schema) → CTA. *(Paridad EN/FR/RU = Fase 4.)*
- [x] **3.2** Enlazado interno contextual añadido en cada landing (2–3 a experiencias/posts + reserva). Verificado con crawl: **cero páginas huérfanas** y cero 404 internos.
- [x] **3.3** H1 de la home cambiado a `Alquiler de barco privado en Marbella — De Antonio D50` (categoría→modelo) en los 4 idiomas (ES/EN/FR/RU), manteniendo el estilo y el resaltado teal del modelo.
- [x] **3.4** Creada la página de diferenciación `/barco-privado-vs-plataformas` (ES, ~830 palabras, tono comparativo honesto con tabla) + enlazada en el footer de las 25 páginas ES y añadida al sitemap. *(Versión EN = Fase 4.1.)*

## FASE 4 — Internacionalización del contenido

- [x] **4.1** Creados en **inglés (UK)** los 5 posts del blog (localizados: "hen party", "boat hire", "marriage proposal") y la página de diferenciación `/private-boat-vs-rental-platforms`. Blog EN (`/yacht-blog`) repuntado a los 5 posts EN + tarjeta de precios añadida.
- [x] **4.2** Paridad EN: las 9 landings de experiencia EN ampliadas a 600–900 palabras con mini-FAQ (FAQPage) y enlaces internos EN, igual que las ES. Todas existían; ninguna faltaba.
- [x] **4.3** FR y RU: todas las páginas ya existían traducidas (sitio 4-idiomas completo). Ampliadas las 2 landings principales en cada uno (FR: sunset + EVJF; RU: sunset + девичник). *Backlog: ampliar el resto de landings FR/RU y traducir los 5 posts a FR/RU (solo existe la versión de precios FR/RU).*
- [x] **4.4** hreflang recíproco ES↔EN añadido a los 5 posts + páginas de diferenciación; landings ya tenían hreflang de las 4 lenguas. Sitemap a 76 URLs con las nuevas páginas EN.

## FASE 5 — Rendimiento

- [x] **5.1** Convertidas las 17 imágenes JPG a **WebP** (reescaladas a máx. 1920px, calidad 80): **20 MB → 1,7 MB (−92%)**. Los `<img>` (146) se envolvieron en `<picture>` con `<source type="image/webp">` + fallback JPG; los 52 heroes con `background-image` CSS pasan a `.webp`. *(AVIF y `srcset` multi-ancho = refinamiento futuro; el mayor ahorro ya está capturado.)*
- [x] **5.2** Verificado: todas las imágenes ya tenían `loading` o `fetchpriority`; las imágenes LCP conservan `fetchpriority="high"` (no lazy) y el resto `loading="lazy"`.
- [x] **5.3** Scripts de terceros ya diferidos: Cookiebot `async`, GA4 `async` + `type="text/plain"` (bloqueado hasta consentimiento). Único recurso bloqueante: hoja de fuentes de Google (con `preconnect` + `display=swap`), aceptable.
- [ ] **5.4** Lighthouse comparativo: **a ejecutar tras el deploy** (requiere el sitio servido; ver 6.4). Mejora esperada muy alta por la reducción de imágenes de 20 MB → 1,7 MB en el LCP.

## FASE 6 — Verificación final

- [ ] **6.1** Crawl completo del build: cero 404 internos, cero redirecciones en cadena.
- [ ] **6.2** Validar todos los JSON-LD (FAQPage, LocalBusiness, Product) sin errores.
- [ ] **6.3** Comprobar en el build: un solo H1 por página, titles y metas únicos en las 4 lenguas, canonicals hacia `https://www.rentboatmarbella.com`.
- [ ] **6.4** Comprobar que sitemap.xml se genera correcto en el deploy de Vercel y que robots.txt lo referencia.
- [ ] **6.5** Generar `SEO-CHANGELOG.md` con el resumen de todo lo hecho y lo que queda pendiente de datos del propietario (teléfono +34, dirección exacta del amarre, datos fiscales para legales).

---

## Tareas manuales para el propietario (Claude Code NO puede hacerlas)

1. **Google Business Profile:** completar/reclamar la ficha con categoría "Servicio de alquiler de barcos", dirección del amarre exacto, fotos reales del De Antonio D50, horario y web. Es media SERP local.
2. **Reseñas:** pedir reseña de Google a cada cliente al desembarcar (QR o WhatsApp automático).
3. **Google Search Console:** verificar la propiedad, enviar el sitemap nuevo y revisar cobertura tras el deploy.
4. **Autoridad/enlaces:** alta en directorios náuticos y de turismo de la Costa del Sol, contacto con conserjerías de hoteles de la Milla de Oro, nota de prensa local sobre el De Antonio D50 en Puerto Banús.
5. **Marca:** vigilar la confusión con *rentalboatmarbella.com* (competidor con nombre casi idéntico); mantener nombre, teléfono y dirección idénticos en web, GBP y redes.

## Keywords de referencia (para títulos, H1 y contenido)

| Página | Keyword principal (ES) | Keyword EN |
|---|---|---|
| Home | alquiler barco privado marbella | private boat hire marbella |
| Flota | alquiler yate puerto banús | yacht charter puerto banus |
| Sunset | sunset tour en barco marbella | sunset boat trip marbella |
| Despedidas | despedida de soltera en barco marbella | hen party boat marbella |
| Delfines | avistamiento de delfines marbella | dolphin watching marbella |
| Gibraltar | excursión en barco a gibraltar desde marbella | boat trip to gibraltar from marbella |
| Post precios | cuánto cuesta alquilar un barco en marbella | how much does it cost to rent a boat in marbella |
| Post calas | mejores calas para fondear marbella | best coves marbella by boat |
