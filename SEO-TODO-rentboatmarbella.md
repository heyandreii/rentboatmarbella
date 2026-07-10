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

- [ ] **2.1 Schema FAQPage** en la home: convertir la FAQ ya existente en JSON-LD `FAQPage`. Validar con https://validator.schema.org.
- [ ] **2.2 Schema LocalBusiness** (subtipo `TouristAttraction` o `BoatRental` vía `additionalType`) en todas las páginas: nombre, URL, teléfono, dirección con el amarre/puerto exacto (**pedir al propietario si no consta en el repo**), `areaServed: Marbella / Puerto Banús`, horario, `priceRange: €€€€`, enlaces `sameAs` a redes sociales y perfil de Google Business.
- [ ] **2.3 Schema Product/Offer** en las landings de experiencia con nombre, descripción, precio y moneda.
- [ ] **2.4 Páginas legales:** crear **Términos y Condiciones** y **Política de Cookies** (ahora aparecen en el footer sin enlace). Redactar plantilla estándar adaptada a chárter náutico en España y enlazarlas en el footer en los 4 idiomas. Marcar con `TODO:` los datos legales que deba confirmar el propietario (razón social, NIF, dirección fiscal).
- [ ] **2.5 Teléfono:** añadir un número español (+34) junto al +33 en header/footer/contacto. Si no existe en el repo, dejar `TODO: confirmar +34 con propietario` y preparar el hueco.
- [ ] **2.6 Formato de cifras en EN:** unificar todos los precios de la versión inglesa al formato inglés (`€1,200`, `€1,800`, `€3,000`). Revisar FR y RU con el formato correcto de cada locale.
- [ ] **2.7 Selectores de reserva:** ordenar opciones de forma lógica (personas: 1→máx; duración: 2 h → 4 h → día completo).
- [ ] **2.8 robots.txt y sitemap.xml:** crear/corregir. El sitemap debe incluir todas las páginas de los 4 idiomas y **ninguna URL rota**; regenerarse en cada build; referenciarse desde robots.txt.
- [ ] **2.9 hreflang:** implementar etiquetas `hreflang` recíprocas entre ES/EN/FR/RU + `x-default` (ES) en todas las páginas, o vía sitemap si el framework lo facilita.

## FASE 3 — Contenido de las landings de experiencia

Ampliar cada landing (sunset, despedidas, delfines, Gibraltar, cumpleaños, pedidas, eventos de empresa) de ~250 a **600–900 palabras**, manteniendo el diseño actual:

- [ ] **3.1** Estructura por landing: intro con keyword en las primeras 100 palabras → itinerario/qué incluye la experiencia → qué se ve/ruta → para quién es ideal → mini-FAQ propia (3–4 preguntas, con schema FAQPage) → CTA.
- [ ] **3.2** Enlazado interno contextual: cada landing enlaza a 2–3 páginas relacionadas (otras experiencias, posts del blog, flota) con anchor text descriptivo. Ninguna página del sitio debe quedar huérfana.
- [ ] **3.3** H1 de la home: cambiar a un patrón tipo `Alquiler de barco privado en Marbella — De Antonio D50` (categoría primero, modelo después). Adaptar en los 4 idiomas.
- [ ] **3.4** Página nueva de diferenciación: `Barco privado vs. plataformas de alquiler` — por qué reservar directo un chárter 100% privado (nunca compartido, patrón multilingüe, todo incluido, reembolso por mala mar) frente a marketplaces. Tono comparativo honesto, sin nombrar marcas de forma negativa.

## FASE 4 — Internacionalización del contenido

- [ ] **4.1** Traducir al **inglés** los 5 posts del blog y la página de diferenciación (localizar, no traducir literal: el público objetivo son británicos — usar "hen party", "stag do", "boat hire").
- [ ] **4.2** Comprobar paridad EN de todas las landings de experiencia; crear las que falten.
- [ ] **4.3** FR y RU: traducir al menos la home, flota, reserva y las 2 landings principales (sunset y despedidas). Marcar el resto como backlog.
- [ ] **4.4** Verificar que el hreflang cubre todas las nuevas páginas.

## FASE 5 — Rendimiento

- [ ] **5.1** Convertir las imágenes hero y de galería a **WebP/AVIF** con `srcset`/`sizes` responsivos (o el componente de imagen del framework). Objetivo: LCP < 2,5 s en móvil.
- [ ] **5.2** `loading="lazy"` en todas las imágenes bajo el fold; `fetchpriority="high"` en la imagen LCP.
- [ ] **5.3** Revisar scripts de terceros que bloqueen render; diferir lo no crítico.
- [ ] **5.4** Repetir Lighthouse y comparar con las puntuaciones de la Fase 0. Documentar mejora en el PR.

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
