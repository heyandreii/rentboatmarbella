# Contexto completo del proyecto — rentboatmarbella.com

> **Para qué sirve este archivo.** Pégalo entero al empezar una conversación nueva
> con un asistente de IA que no conoce el proyecto. Con esto debería entender el
> negocio, el stack, todo el historial de trabajo, la configuración externa, el
> estado y las reglas — sin haber vivido las conversaciones anteriores.
>
> **Última actualización: 14 de agosto de 2026.** Las secciones marcadas
> **[ACTUALIZAR EN CADA REVISIÓN]** caducan: si la fecha de arriba tiene más de un
> mes, trátalas como orientativas y pide datos frescos antes de decidir nada.
>
> ⚠️ **Este archivo va por detrás desde el 19 de agosto de 2026.** Las tandas de
> ese día (limpieza de datos sin confirmar, `sizes` e imágenes responsivas, 20
> posts de zona, y el arranque del programa multiidioma) **no** están recogidas
> aquí. Sus cifras de tamaño —100 URLs, 26 posts, 332 bloques JSON-LD— están
> desfasadas: los números buenos son los de **`ESTADO.md` §1**, y el detalle
> técnico está en `SEO-CHANGELOG.md`. Los cambios de fondo que hay que conocer
> antes de tocar nada:
>
> - **El sitio ya no son 4 idiomas, sino 5 + un programa que lo lleva a 8.**
>   La oleada italiana está **completa**: 29 páginas (core, 8 landings, el
>   formulario `/prenota`, el índice `/blog-nautica-marbella` y 14 posts). El
>   italiano es el quinto idioma a todos los efectos. **La siguiente oleada es
>   NL.** Convenciones de slug, formato de cifras y **redacciones canónicas
>   IT/NL/DE** en `README.md` → «Idiomas del programa multiidioma».
> - **Ya son 5 formularios de reserva, no 4**: `/reservar`, `/booking`,
>   `/reservation`, `/zabronirovat` y `/prenota`. Todo lo que este archivo dice
>   «de los 4 formularios» hay que leerlo como «de los 5».
> - **Se atiende por WhatsApp y email en italiano** (confirmado el 19/08/2026).
>   Es publicable **solo en las páginas IT**, con la redacción canónica del
>   README. **El patrón sigue hablando ES · EN · FR · RU** y ninguna página dice
>   otra cosa: son dos datos distintos y no se mezclan. Para NL, DE y AR el dato
>   sigue sin confirmar.
> - **Sí hay equipo de sonido a bordo, con Bluetooth**, y el cliente conecta su
>   propia música (aclarado el 19/08/2026; corrige la confirmación anterior del
>   mismo día, que este archivo puede seguir dando por buena). Solo se publica con
>   la **redacción canónica** del `README.md` y solo donde el criterio editorial
>   lo permite: landings de fiesta, posts de boat party, fichas de flota y
>   comparativas — **no** en pedida, bodas, sunset, delfines ni Gibraltar. Siguen
>   prohibidos **DJ, barra premium, altavoces portátiles y karaoke**.
> - **El selector de idioma es un desplegable en todos los anchos**, no solo en
>   móvil como dice §7 (PR #15) más abajo.
> - **Hay datos que se confirmaron falsos el 19/08** —nevera,
>   ducha, colchoneta flotante, descorche— y que este archivo puede seguir dando
>   por buenos. Manda `README.md` → «Regla anti-invención», y lo vigila
>   `scripts/check-datos-comerciales.sh`.

**Documentos hermanos en el repo** (este los resume; ellos tienen el detalle):

| Archivo | Qué contiene |
|---|---|
| `ESTADO.md` | Documento vivo: qué está hecho, qué falta, reglas. El resumen ejecutivo. |
| `README.md` | Cómo trabajar en el repo, comandos, reglas duras. |
| `SEO-CHANGELOG.md` | Detalle técnico de cada tanda de trabajo (julio–agosto 2026). |
| `SEO-TODO-rentboatmarbella.md` | Plan SEO original de julio 2026 (Fases 0–6), histórico. |
| `docs/GA4-embudo-reserva.md` | Cómo leer la analítica del embudo de reserva. |

---

# 1. El negocio

## 1.1 Producto

Un **solo barco**, no una flota:

| Dato | Valor |
|---|---|
| Modelo | **De Antonio D50** |
| Año | **2026** |
| Eslora | **15 metros** |
| Motorización | **2× Mercury V12 600 CV — 1.200 CV totales** |
| Capacidad | **hasta 10 personas** (por barco, no por persona) |
| Patrón | **Incluido siempre** (titulado, multilingüe ES/EN/FR/RU — **no** italiano a bordo; la atención en italiano es por WhatsApp y email). El cliente no necesita licencia. |
| Amarre | **Puerto Banús, 29660 Marbella (Málaga)** — todas las salidas parten de ahí |

Formato de la motorización por idioma (importante, se usa literal en las fichas):
ES `2× Mercury V12 600 CV` · EN `2× Mercury V12 600 hp` · FR `2× Mercury V12 600 ch` ·
RU `2× Mercury V12 600 л.с.`

## 1.2 Propuesta de valor

**Chárter 100 % privado y premium.** Nunca compartido con desconocidos, reserva
directa sin marketplace de por medio, todo incluido y sin sorpresas. El
posicionamiento explícito es **no competir en precio, competir en exclusividad**:
un único barco premium bien cuidado en vez de una flota heterogénea.

Diferenciadores que se usan en el contenido:

- Salida privada garantizada desde Puerto Banús.
- Patrón titulado multilingüe incluido.
- Reembolso del 100 % si el patrón considera que el mar no es seguro; cambio de
  fecha sin coste con 24 h de antelación.
- Reserva directa: se responde en menos de 2 horas.

Competencia de referencia: marketplaces (**Click&Boat, SamBoat, Nautal**) y
operadores locales (**Marbella Boat Charter, Nautica Marbella, La Dama María**).
Existe además un competidor de nombre casi idéntico, **rentalboatmarbella.com**
(con «rental»); hay una tarea abierta de vigilar esa confusión de marca.

## 1.3 Tarifas — datos confirmados (regla anti-invención, ver §8)

| Duración | Precio | Nota |
|---|---|---|
| **2 h** | **1.200 €** | Es también el «desde» que se usa como suelo en las landings corporativas |
| **4 h** | **1.800 €** | |
| **8 h (día completo)** | **3.000 €** | |
| **A medida** | Presupuesto | Bodas, eventos de empresa, pedidas, rutas a Gibraltar |

- **IVA incluido.** El texto de referencia es: *«lo que ves es el precio final:
  patrón, combustible de la ruta habitual e IVA incluido»*.
- **NO existe tarifa de 6 h ni de 2.400 €.** Se inventó una vez y se eliminó en el
  PR #7. No reintroducir.
- **No se publican equivalencias por hora** (precio/hora). Decisión expresa del
  propietario, tomada al descartar una sección de la guía de precios. No
  reintroducir sin confirmación.
- Formato de cifras por idioma: ES `1.200€` · EN `€1,200` · FR/RU `1 200 €`.

## 1.4 Qué incluye la tarifa

**Patrón titulado, combustible de la ruta habitual, seguro, paddle surf, snorkel,
catering ligero (fruta y frutos secos), agua y refrescos y una botella de champán
de cortesía**, más el equipo de seguridad completo y la plataforma de baño. Todo
con IVA incluido.

Confirmado por el propietario el **19 de agosto de 2026**, cerrando la última duda
abierta sobre lo que va incluido. Ese mismo día **subió el detalle de copa a
botella**: la redacción de la botella **sustituye** a la de la copa en todas
partes. Criterio: **una botella por reserva**, incluida en la tarifa y en todas las
duraciones; no se promete marca, tamaño ni más de una. Redacción canónica por
idioma (las 5 publicadas + NL/DE, preparadas para su oleada):

| Idioma | Fórmula |
|---|---|
| ES | catering ligero, agua y refrescos, y botella de champán de cortesía |
| EN | light catering, water and soft drinks, and a complimentary bottle of champagne |
| FR | catering léger, eau et sodas, et une bouteille de champagne offerte |
| RU | лёгкий кейтеринг, вода и напитки, и бутылка шампанского в подарок |
| IT | catering leggero, acqua e bibite e una bottiglia di champagne in omaggio |
| NL | lichte catering, water en frisdrank en een fles champagne van het huis |
| DE | leichtes Catering, Wasser und Softdrinks sowie eine Flasche Champagner als Aufmerksamkeit des Hauses |

Excepción: en las **rutas a Gibraltar** el combustible va aparte (la ruta se sale
del recorrido habitual). Así figura ya en la home.

### Lo que NO existe a bordo (confirmado 19/08/2026 — no publicar)

- ~~**Equipo de sonido / altavoz Bluetooth.**~~ **Sí hay** — el propietario aclaró
  ese mismo día que la confirmación era errónea y que la retirada de las 14 páginas
  había sido decisión editorial, no de existencia. Hay **equipo de sonido con
  Bluetooth** y el cliente **conecta su propia música**. Restaurado en 36 páginas
  con la redacción canónica del `README.md`. Lo que sigue sin existir: **DJ, barra
  premium, altavoces portátiles adicionales y karaoke**.
- **Nevera y ducha de agua dulce.** No hay.
- **Colchoneta flotante.** No hay. El único equipo de agua es el **paddle surf**
  (más el material de snorkel). Confirmado el 19/08/2026 tras detectarse en 2
  páginas; retirada de ambas. Reapareció una tercera en el post RU de precios
  («плавучий матрас»), retirada el 19/08/2026 al ampliar el patrón del grep.
- **Política de descorche.** No se promete que el cliente pueda subir su propia
  bebida. Eliminado de las 14 páginas que lo decían.
- **Agua y hielo como claim aparte.** El agua y los refrescos van dentro de lo
  incluido; el hielo no se menciona.
- **Globos sueltos.** Solo existen dentro del extra «decoración especial (+120 €)».

### Alcohol

El único alcohol incluido es **una botella de champán de cortesía**. El resto de
bebidas incluidas son sin alcohol. Las **botellas adicionales** siguen siendo extra
de pago, y hay que nombrarlas así —«adicional / additional / supplémentaire /
дополнительная / aggiuntiva»— para que no choquen con la incluida. Ninguno de los
4 extras del formulario de reserva es una botella de champán (son fotógrafo, moto
de agua, catering ampliado y decoración especial), así que ahí no hay conflicto.

### El catering del sunset (antes 🔴, ahora cerrado)

Las 4 landings de sunset prometían tabla de quesos y embutidos y una botella para
brindar. **El propietario confirma que el sunset no lleva catering especial:** es
el mismo catering ligero + agua y refrescos + botella de champán de cortesía que
el resto de salidas. Las 4 páginas se corrigieron el 19/08/2026.

## 1.5 Extras (los del formulario de reserva)

| Extra | Precio |
|---|---|
| Moto de agua | **+250 €** |
| Catering ampliado | **+180 €** |
| Decoración especial | **+120 €** |
| Fotógrafo / videógrafo profesional | **a consultar** (sin precio; marcado `data-request="1"`) |

Son exactamente los cuatro que ofrece `/reservar` y sus equivalentes en EN/FR/RU.
Cualquier extra que no esté en esta lista **no existe** a efectos de contenido.

## 1.6 Experiencias con landing propia

Nueve experiencias, cada una con página en los 4 idiomas:

sunset tour · despedida de soltera · despedida de soltero · avistamiento de
delfines · excursión a Gibraltar · cumpleaños · pedida de matrimonio · fotos de
boda · eventos de empresa.

## 1.7 Clientela

Cuatro mercados, que es exactamente el motivo de los cuatro idiomas:
**británica, rusa, francesa y española**. El sitio se redacta localizando, no
traduciendo: cada idioma adapta gancho, ejemplos y referencias culturales a su
mercado (ver §3, PR #8).

## 1.8 Datos de empresa

| Campo | Valor |
|---|---|
| Razón social (`legalName` en schema) | **Bulgarian Business Management Company EOOD** |
| NIF (`taxID` en schema) | **N0396825B** |
| Domicilio social | Complejo Resid. Yuzhen Park, Bl. 123, Pl. 5 – Apto. 18, Distrito de Triaditsa, 1421 Sofía (Bulgaria) |
| Nombre comercial (`name` en schema) | **Rent Boat Marbella** |
| Dirección en el schema (`address`) | Puerto Banús, 29660 Marbella (Málaga) — el amarre |

El domicilio social de Sofía **solo aparece en el Aviso Legal**; en todo lo demás
la dirección es el amarre de Puerto Banús, que es lo relevante para SEO local.

## 1.9 Canal de reservas real

**No hay pasarela de pago ni reserva automática.** El formulario es un generador
de leads con dos salidas simultáneas:

1. **WhatsApp** → `wa.me/33767126360` (**+33 7 67 12 63 60**) con el mensaje
   prerrellenado: duración, invitados, fecha, extras, total estimado, nombre,
   email, teléfono completo con prefijo y peticiones especiales.
2. **Email** → `/api/lead` manda un aviso a **info@rentboatmarbella.com** vía
   Resend, para no perder a quien reserva desde un ordenador sin WhatsApp Web.

Falta un **teléfono español +34**: hay un hueco `TODO` en el footer de todas las
páginas y hoy solo se muestra el +33. Es un dato pendiente del propietario.

---

# 2. Stack técnico

## 2.1 Arquitectura

- **HTML estático puro. Sin framework, sin paso de build, sin `package.json`.**
  Los `.html` se sirven tal cual. Estilos inline en cada página + `mobile.css`
  para lo responsive.
- **Hosting: Vercel** (cuenta **«enunpop»**). Deploy automático desde la rama
  `main` del repo de GitHub **`heyandreii/rentboatmarbella`**. Cada push a `main`
  despliega a producción.
- **`vercel.json`**: `cleanUrls: true`, `trailingSlash: false`, **132
  redirecciones 301** y las cabeceras de caché.
- **Una única función serverless**: `api/lead.js` (Node en Vercel, sin
  dependencias — usa el `fetch` nativo del runtime).
- **Dominio de producción:** `https://www.rentboatmarbella.com` (todos los
  canonicals apuntan ahí, con `www`).
- **Se desarrolla con Claude Code**, en local, sobre este repo.

## 2.2 Cabeceras de caché (`vercel.json`) — importante

| Ruta | Cache-Control |
|---|---|
| `/(.*)` (HTML) | `public, max-age=0, must-revalidate` |
| `/img/(.*)` | `public, max-age=31536000, immutable` |
| `/(.*).(css\|js\|woff2\|woff\|ttf)` | `public, max-age=31536000, immutable` |

De aquí sale una de las reglas duras: **si editas `mobile.css` o cualquier `.js`,
hay que subir el `?v=` de su etiqueta en todas las páginas que lo cargan**, o los
visitantes recurrentes verán el HTML nuevo con el asset viejo (durante un año).
Hoy `js/form-tracking.js` se sirve como `?v=1`.

## 2.3 Tamaño y estructura

**100 URLs en el sitemap** = **74 páginas `.html` en la raíz** + **26 posts en
`post/`**. También: 4 formularios de reserva (uno por idioma) y **332 bloques
JSON-LD** validados.

> ⚠️ **Desfasado.** Hoy son **159 URLs**, 89 páginas en la raíz, **70 posts**,
> **5 formularios** (con `/prenota`), **5 índices de blog** y **559 bloques JSON-LD**. Los números
> buenos están en `ESTADO.md` §1.

```
/                          74 × .html   páginas del sitio (4 idiomas, URLs traducidas)
/post/                     26 × .html   artículos del blog
/api/lead.js                            función serverless (Resend)
/js/lang-switcher.js                    desplegable de idioma del header (móvil)
/js/form-tracking.js                    embudo GA4 (se carga con ?v=1)
/img/                                   WebP + fallback JPG, variantes -640/-1280
/scripts/                               verificadores y tests (ver §2.6)
/brand-assets/                          IGNORADO por git (ojo: lo que viva solo ahí da 404 en producción)
mobile.css  robots.txt  sitemap.xml  vercel.json  _redirects
```

## 2.4 Estructura de URLs por idioma

No hay prefijos `/es/`, `/en/`… **cada idioma tiene su propio slug traducido.**
Las homes son `/` (ES), `/en`, `/fr`, `/ru`.

| Página | ES | EN | FR | RU |
|---|---|---|---|---|
| Home | `/` | `/en` | `/fr` | `/ru` |
| Reservar | `/reservar` | `/booking` | `/reservation` | `/zabronirovat` |
| Flota | `/flota-barcos-marbella` | `/fleet` | `/flotte` | `/flot` |
| Actividades | `/actividades-barco-marbella` | `/activities` | `/activites` | `/aktivnosti` |
| Blog (índice) | `/blog-nautico-marbella` | `/yacht-blog` | `/blog-nautique` | `/morskoy-blog` |
| Sunset | `/sunset-tour-barco-marbella` | `/sunset-tour-yacht-marbella` | `/sunset-tour-bateau-marbella` | `/sunset-tour-yakhta-marbella` |
| Despedida soltera | `/despedida-soltera-barco-marbella` | `/hen-party-yacht-marbella` | `/evjf-yacht-marbella` | `/devichnik-yakhta-marbella` |
| Despedida soltero | `/despedida-soltero-barco-marbella` | `/bachelor-party-yacht-marbella` | `/evg-bateau-marbella` | `/malchishnik-yakhta-marbella` |
| Delfines | `/avistamiento-delfines-marbella` | `/dolphin-watching-marbella` | `/observation-dauphins-marbella` | `/nablyudenie-delfinov-marbella` |
| Gibraltar | `/ruta-barco-gibraltar-marbella` | `/gibraltar-boat-trip-marbella` | `/excursion-bateau-gibraltar-marbella` | `/ekskursiya-gibraltar-marbella` |
| Cumpleaños | `/cumpleanos-en-barco-marbella` | `/birthday-boat-marbella` | `/anniversaire-yacht-marbella` | `/den-rozhdeniya-yakhta-marbella` |
| Pedida | `/pedida-matrimonio-barco-marbella` | `/proposal-yacht-marbella` | `/demande-mariage-yacht-marbella` | `/predlozhenie-ruki-yakhta-marbella` |
| Fotos de boda | `/fotos-boda-barco-marbella` | `/wedding-photos-yacht-marbella` | `/photos-mariage-yacht-marbella` | `/svadebnye-foto-yakhta-marbella` |
| Eventos empresa | `/eventos-empresa-barco-marbella` | `/corporate-events-boat-marbella` | `/evenements-entreprise-bateau-marbella` | `/korporativy-yakhta-marbella` |
| Vs. plataformas | `/barco-privado-vs-plataformas` | `/private-boat-vs-rental-platforms` | — | — |

**Legales** (4 × 4 = 16 páginas): aviso legal (`/aviso-legal` · `/legal-notice` ·
`/mentions-legales` · `/pravovaya-informatsiya`), privacidad
(`/politica-privacidad` · `/privacy-policy` · `/politique-confidentialite` ·
`/politika-konfidentsialnosti`), términos (`/terminos-condiciones` ·
`/terms-conditions` · `/conditions-generales` · `/usloviya-ispolzovaniya`) y
cookies (`/politica-cookies` · `/cookies-policy` · `/politique-cookies` ·
`/politika-cookie`).

> **Trampa conocida:** `/flot` es la **flota RUSA**, no un enlace truncado de
> `/flota-barcos-marbella`. Ya pasó una vez que se propuso redirigirlo; hacerlo
> rompería la flota rusa. No lo redirijas.

## 2.5 Los 26 posts del blog

| Idioma | Posts |
|---|---|
| **ES (8)** | `cuanto-cuesta-alquilar-barco-marbella` · `mejores-calas-fondear-marbella` · `alquilar-barco-marbella-invierno` · `despedida-soltera-barco-consejos` · `pedida-matrimonio-en-el-mar` · `necesitas-licencia-alquilar-barco-marbella` · `bodas-eventos-barco-marbella` · `alquiler-barco-costa-del-sol-puerto-banus` |
| **EN (8)** | `how-much-cost-rent-boat-marbella` · `best-coves-anchor-marbella` · `rent-boat-marbella-winter` · `hen-party-boat-marbella-guide` · `marriage-proposal-boat-sea` · `do-you-need-licence-rent-boat-marbella` · `boat-party-puerto-banus` · `boat-rental-costa-del-sol-puerto-banus` |
| **FR (5)** | `combien-coute-location-bateau-marbella` · `meilleures-criques-mouillage-marbella` · `louer-bateau-marbella-hiver` · `evjf-bateau-marbella-conseils` · `demande-mariage-en-mer` |
| **RU (5)** | `skolko-stoit-arenda-yakhty-marbella` · `luchshie-buhty-marbella` · `arenda-yakhty-marbella-zimoy` · `devichnik-na-yakhte-sovety` · `predlozhenie-ruki-v-more` |

Se sirven como `/post/<slug>` (sin `.html`, gracias a `cleanUrls`).

Patrón fijo de cada post: `title` ≤ 60 con keyword · meta description 150–160 con
CTA · un solo H1 · jerarquía H2/H3 · keyword en las primeras 100 palabras · 2–4
enlaces internos a landings + 1 a reserva · JSON-LD **BlogPosting +
BreadcrumbList + FAQPage**.

## 2.6 Scripts de verificación del repo

| Script | Qué comprueba | Cómo se ejecuta |
|---|---|---|
| **`scripts/check-links.sh`** | **Doble fase.** *Fase 1 (offline):* para cada `/post/<slug>` del sitemap lee el `<html lang>` del post y exige que su índice de idioma lo enlace (`es`→`blog-nautico-marbella`, `en`→`yacht-blog`, `fr`→`blog-nautique`, `ru`→`morskoy-blog`); falla si el sitemap lista un post inexistente o de idioma desconocido. *Fase 2 (red):* curl con cache-buster a todas las URLs internas, exige 200. Un 200 tras redirigir a otro host cuenta como fallo (Preview con SSO). Exit 1 si falla cualquiera. | `scripts/check-links.sh` (producción) o `scripts/check-links.sh http://127.0.0.1:8000` |
| **`scripts/check-lang-switcher.py`** | Que ningún enlace del selector de idioma apunte a una página inexistente o a una que en realidad está en otro idioma. Offline. | `scripts/check-lang-switcher.py` |
| `scripts/apply-lang-switcher.py` | Regenera el selector de idioma del header desde los `hreflang` de cada página. | `scripts/apply-lang-switcher.py` |
| **`scripts/test-booking-form.js`** | **380 comprobaciones** sobre los 5 formularios (ES/EN/FR/RU/IT): validación real extraída del HTML servido (marcadores `[RBM-VALIDATION-*]`), lista de países (ISO, prefijos, idioma, orden, sin duplicados), prefijo por defecto, que `validate()` va **antes** de `track.success()` / `/api/lead` / `window.open`, y que a GA4 no viaja ningún valor tecleado. | `node scripts/test-booking-form.js` |
| **`scripts/test-lead-api.js`** | **21 comprobaciones** de `/api/lead` con Resend simulado, sin red ni credenciales: asunto, 11 campos, destinatario, `reply_to`, guardas 405/400/413/422/500/502, que la API key nunca viaja a la respuesta, escapado de `<img onerror>`, limpieza de `\r\n`, limitador por IP. | `node scripts/test-lead-api.js` |
| `scripts/check-offer-price.sh` | Que ningún `Offer` del sitio tenga `priceCurrency` sin `price`. | `scripts/check-offer-price.sh` |

> **Nota sobre pruebas en local:** `python3 -m http.server` **no** replica
> `cleanUrls`, así que los `/post/<slug>` sin `.html` darán 404 en local aunque el
> archivo exista. Para validar rutas limpias hay que ir contra la URL de *Preview*
> de Vercel del PR o contra producción tras el deploy.

---

# 3. Historial cronológico (PR #1 a #16)

Todo el trabajo va en **rama + Pull Request**, nunca directo a `main`. Antes de
julio de 2026 hubo commits sueltos de subida de archivos; el trabajo estructurado
empieza con el plan SEO.

## 3.0 Antes de los PR — el plan SEO (julio 2026, Fases 1–6)

El punto de partida eran **58 páginas** y un diagnóstico con una fuga grave.

- **Fase 1 — Reparar los 404 del blog (crítico).** Los índices de blog enlazaban a
  7 posts `/post/...` que **no existían**: no había ni carpeta `post/`. Se
  crearon los 5 posts ES + las versiones FR y RU del post de precios. Resultado:
  cero 404 internos.
- **Fase 2 — Quick wins técnicos.** `LocalBusiness` JSON-LD en todas las páginas
  (`additionalType` BoatRental, `areaServed`, `priceRange:"€€€€"`, `sameAs`
  Instagram, dirección + geo). `Product`/`Offer` en las landings, `FAQPage` en las
  homes. **16 páginas legales** (4 tipos × 4 idiomas) con datos fiscales reales.
  Formato de cifras unificado por idioma. `robots.txt` + `sitemap.xml` (76 URLs).
  `hreflang` recíproco + `x-default`.
- **Fase 3 — Contenido ES.** 9 landings de experiencia ampliadas a 600–900
  palabras (qué incluye → ruta → para quién → mini-FAQ con FAQPage → CTA). H1 de
  la home cambiado de categoría a modelo: *«Alquiler de barco privado en Marbella
  — De Antonio D50»*. Nueva página `/barco-privado-vs-plataformas`. Cero páginas
  huérfanas.
- **Fase 4 — Internacionalización.** 5 posts EN + `/private-boat-vs-rental-platforms`.
  9 landings EN ampliadas a paridad con ES. FR y RU: ampliadas sunset + despedida.
- **Fase 5 — Rendimiento.** **17 imágenes JPG → WebP: 20 MB → 1,7 MB (−92 %)**.
  146 `<img>` envueltos en `<picture>` con fallback, 52 heroes CSS a `.webp`,
  `fetchpriority="high"` en el LCP y `loading="lazy"` en el resto.
- **Fase 6 — Verificación.** Cero 404, cero cadenas de redirección, cero
  huérfanas, JSON-LD válido, 1 H1 por página, titles y metas únicos, canonicals a
  `https://www.rentboatmarbella.com`, sitemap válido y referenciado.

También en esa etapa: datos fiscales reales en el schema y en las legales,
sustitución del extra «Segundo tripulante» por «Fotógrafo/videógrafo», y
`.gitignore` (se dejó de trackear `.DS_Store`).

## 3.1 Los PR, uno a uno

### PR #1 — Formulario de reserva funcional con WhatsApp (10 jul)
`feat/booking-form-whatsapp`. El formulario pasa de decorativo a funcional en los
4 idiomas: al pulsar «Solicitar reserva» se abre WhatsApp con el mensaje
prerrellenado (duración, invitados, fecha, extras, total).

### PR #2 — Accesibilidad WCAG AA + rendimiento (10 jul)
`fix-accesibilidad-rendimiento`. Labels, atributos `aria`, landmark `main`,
imágenes responsivas y fuentes no bloqueantes. **La accesibilidad sube de 58 a
96** en Lighthouse móvil.

### PR #3 — Contraste AA del naranja de marca (10 jul)
`fix-contraste-cta`. El naranja corporativo no pasaba contraste: se pasa a
navy/ámbar en el gris de las specs y en los CTA.

### PR #4 — Diagnóstico de la «regresión» del blog + salvaguarda (15 jul)
`fix-post-regresion-y-limpieza`. **Este es importante para entender el proyecto.**
Se reportaron 3 posts en 404 otra vez. El diagnóstico demostró que **no era una
regresión de código**:

- `git ls-tree origin/main -- post/` → los 3 archivos existen en el remoto.
- `git log --diff-filter=D -- post/` → **vacío**: ningún commit ha borrado nunca
  nada en `post/`.
- Los 3 «rotos» tienen los mismos 11 commits que los que funcionaban.
- El hash del HTML en vivo era idéntico al de `origin/main`.
- `curl` ×3 a cada uno → **200**, `x-vercel-cache: HIT`.

**Causa raíz: artefacto transitorio de caché / propagación de edge de Vercel**
durante un deploy (ventana de cache-miss mientras la nueva deployment propagaba),
que se autorresolvió. *(La «primera vez» sí había sido distinta: commits sin
pushear. La «segunda vez» fue propagación de CDN.)* No había nada que restaurar.

De ahí nace **`scripts/check-links.sh`**, obligatorio antes de cada push. En el
mismo PR: pluralización singular de invitados (1 persona / 1 guest / 1 personne /
1 гость), se descartó redirigir `/flot` (es la flota rusa), y se dejó **pendiente
de confirmación** la discrepancia de capacidad: «11 personas» aparecía en 16
páginas y «10 pax» en 8. Se resolvió a favor de **10** en el commit siguiente,
junto con los headers de caché de `vercel.json` y la ampliación de 14 landings
FR/RU.

### PR #5 — hreflang recíproco en los posts de precios (15 jul)
`fix-hreflang-posts-precios`. El grupo ES/EN/FR/RU del post de precios no
declaraba alternates recíprocos completos. También: reintentos en
`check-links.sh` para evitar falsos positivos de red.

### PR #6 — Plantilla: nav/footer en el idioma equivocado (15 jul)
`fix-post-ru-plantilla`. Posts y páginas legales de idiomas no-ES tenían enlaces
de nav y footer apuntando a rutas ES.

### PR #7 — Eliminar la tarifa de 6 h inexistente (15 jul)
`fix-6h-blogs-fr-ru`. **Se había publicado una tarifa de 6 h que no existe.**
Eliminada, y de ahí sale la **regla anti-invención de datos comerciales** (§8).
Además, los índices de blog FR/RU dejan de mostrar posts de otros idiomas.

### PR #9 — Paquete A: 6 posts nuevos basados en Search Console (11 ago)
`feat/posts-search-data`. Seis posts de 1.000–1.300 palabras escritos contra
consultas reales de Search Console, no contra intuición:

| Post | Idioma | Keyword objetivo |
|---|---|---|
| `necesitas-licencia-alquilar-barco-marbella` | ES | alquiler barco sin licencia marbella |
| `do-you-need-licence-rent-boat-marbella` | EN | boat hire with licence costa del sol |
| `bodas-eventos-barco-marbella` | ES | yates para eventos marbella |
| `boat-party-puerto-banus` | EN | puerto banus boat party |
| `alquiler-barco-costa-del-sol-puerto-banus` | ES | alquiler lancha premium costa del sol |
| `boat-rental-costa-del-sol-puerto-banus` | EN | boat rental costa del sol |

El post geográfico es **uno solo para toda la costa**: decisión deliberada de no
crear páginas por ciudad. Además, enlaces internos desde las homes hacia páginas
que ya estaban en el top 10 (home FR → aniversario y pedida; home ES y guía de
precios → vs-plataformas; home EN → `/fleet`).

**Aquí se descartó la sección «alquiler de barco por horas»** con el precio/hora
resultante de cada bloque: **decisión expresa del propietario, no se publican
equivalencias por hora.**

### PR #8 — Traducir a FR y RU los 4 posts que solo existían en ES (11 ago)
`feat/traducir-4-posts-fr-ru`. **Localización, no traducción literal**: en FR se
compara con las calanques de Cassis y Porquerolles, vuelos directos a Málaga,
vacaciones escolares y terminología EVJF/EVG con coste por persona; en RU se
apunta al público que inverna en la costa y viaja en las vacaciones de fin de año,
con topónimos transliterados (Пуэрто-Банус, Кабопино, Ла-Конча).

| Post ES | FR | RU |
|---|---|---|
| `mejores-calas-fondear-marbella` | `meilleures-criques-mouillage-marbella` | `luchshie-buhty-marbella` |
| `alquilar-barco-marbella-invierno` | `louer-bateau-marbella-hiver` | `arenda-yakhty-marbella-zimoy` |
| `despedida-soltera-barco-consejos` | `evjf-bateau-marbella-conseils` | `devichnik-na-yakhte-sovety` |
| `pedida-matrimonio-en-el-mar` | `demande-mariage-en-mer` | `predlozhenie-ruki-v-more` |

En el mismo PR: **el sitemap llega a 100 URLs**; `check-links.sh` gana la
detección de **posts huérfanos** (presentes en el sitemap pero sin card en su
índice — respondían 200 y el script daba verde, pero eran invisibles para el
usuario y casi huérfanos para Google); y se endurece para que un 200 tras
redirigir a otro host cuente como fallo.

### PR #10 — Correcciones de una auditoría externa (11 ago)
`fix/auditoria-ficha-tecnica-schema-footer`. Cinco hallazgos, verificados uno a
uno contra el repo antes de tocar nada:

1. **Ficha técnica truncada:** la tarjeta de motores mostraba `2× M` en los 4
   idiomas. Corregida a la motorización real, con formato por locale, y añadida
   al `Product` vía `additionalProperty` (`PropertyValue`).
2. **Residuos de la capacidad antigua «12»:** grep global en las 100 páginas →
   solo 2 ocurrencias reales, ambas en `sunset-tour-yacht-marbella` (texto visible
   + FAQPage). Corregidas a 10.
3. **`Organization` + `WebSite` en las 4 homes:** `WebSite` ya existía; se añade
   `Organization` (`@id` `…/#organization`, `legalName`, logo 512×512, `sameAs`
   Instagram) enlazado con `publisher`. El icono de marca vivía solo en
   `brand-assets/` — **ignorado por git, o sea 404 en producción**; se publica
   como `img/logo-icon-512.png`.
4. **Ficha de flota ampliada** ~330–410 palabras por idioma, reforzando el ángulo
   privacidad + lugar.
5. **Footer:** el cuadro «FB» era texto plano sin `href` (no hay Facebook activo).
   Eliminado de las 100 páginas.

Verificación: `check-links.sh` contra producción → 95 URLs, 0 fallos, 26 posts,
0 huérfanos. JSON-LD: **332 bloques en 100 páginas, 0 errores**, validados offline
contra el vocabulario oficial de schema.org (`@type` existente, propiedades
aplicables según `domainIncludes` + `rdfs:subClassOf`), más una muestra por
`validator.schema.org`.

### PR #11 — `Offer` sin `price` en las corporativas (14 ago)
`fix/schema-offer-price-eventos-empresa`. Search Console notificó formalmente el
error: el `Offer` de las 4 landings de eventos de empresa declaraba
`priceCurrency:"EUR"` **sin `price`**.

Barrido previo recorriendo el árbol completo de los 332 bloques JSON-LD (no un
grep): **exactamente esos 4 casos, ningún otro**; los otros 36 `Offer` ya llevaban
`price`.

**Decisión: precio visible + schema**, no solo schema. Marcar un precio que no
aparece en la página incumple la política de datos estructurados de Google y
expone a acción manual. Estado de partida no homogéneo: FR y RU **ya mostraban**
`1 200 €` en el body; ES y EN no tenían ninguna cifra.

| Página | Body | `Offer` |
|---|---|---|
| `eventos-empresa-barco-marbella` | La FAQ «¿Qué incluye el precio del evento?» abre con **1.200€** | `price:"1200"` |
| `corporate-events-boat-marbella` | «What's included & options» abre con **€1,200** | `price:"1200"` |
| `evenements-entreprise-bateau-marbella` | ya mostraba `1 200 €` | `price:"1200"` |
| `korporativy-yakhta-marbella` | ya mostraba `1 200 €` | `price:"1200"` |

El precio se redacta siempre **como suelo, no como tarifa cerrada**: el texto
mantiene el ángulo «presupuesto a medida». Se añadió
`scripts/check-offer-price.sh` como anti-regresión.

### PR #12 — Embudo GA4 anónimo + datos de contacto a WhatsApp (14 ago)
`feat/ga4-form-abandon-tracking`. Objetivo: saber dónde se cae la gente al
reservar **sin recoger ningún dato de identidad**.

Dos hallazgos previos que cambiaron el planteamiento:

1. **El widget de la home no es el formulario de reserva.** Es un buscador de 3
   campos cuyo CTA es un `<a>` a `/reservar`. Como navegar dispara `pagehide`,
   medirlo con el mismo esquema habría contado como abandono a **todo** el que sí
   avanza. Se le dio su propio evento de éxito: `form_continue`.
2. **Nombre, email, teléfono y peticiones no iban a ningún sitio.** Eran
   `<input>` sin `id` ni `name`; el handler montaba el mensaje de WhatsApp solo
   con duración, invitados, fecha, extras y total. **El cliente los rellenaba y se
   perdían, en los 4 idiomas.**

Cambios: nuevo `js/form-tracking.js` compartido por las 8 páginas; los 4 campos de
contacto reciben `id` y se añaden al mensaje de WhatsApp; y se corrige un **bug de
fecha hardcodeada** — los 8 campos de fecha llevaban `value="2026-07-11"`, un mes
en el pasado. Ahora salen vacíos y con `min` = hoy, fijado en tiempo de ejecución
para que no vuelva a caducar.

Verificación con el transporte de GA4 interceptado, recorriendo el embudo en los 4
idiomas: los 7 eventos de `/reservar` y los 5 de la home salen correctos;
`form_start` una sola vez por sesión; `form_abandon` una sola vez aun recibiendo
dos `pagehide` y un `visibilitychange`, y suprimido si hubo éxito. **Prueba de
fuga:** campos rellenados con cadenas canario, buscadas en todo el tráfico hacia
Google (URL y cuerpo de los POST por lotes, codificado y descodificado) → **cero
coincidencias**. El mensaje de WhatsApp, en cambio, sí llega completo.

### PR #13 — Aviso por email de cada solicitud vía Resend (14 ago)
`feat/api-lead-email`. Nueva función serverless `/api/lead`: recibe el formulario
por POST y manda el correo con **Resend**, leyendo `process.env.RESEND_API_KEY`.
`from` con dominio verificado (`reservas@`), destinatario `info@`, y `reply_to`
= email del cliente. Sin `package.json`: el runtime de Node de Vercel ya trae
`fetch`, se llama a la API REST directamente.

Al ser un endpoint público sin autenticar lleva: solo POST, tope de 8 KB de
cuerpo, tope de longitud por campo, limpieza de caracteres de control (evita
cabeceras fabricadas), escapado HTML de todo lo que escribe el usuario y un
limitador de **10 peticiones/minuto por IP** — *best-effort*: la memoria muere con
la instancia y Vercel levanta varias, así que frena un bucle accidental, no un
ataque decidido. **El correo solo se manda si hay email o teléfono** (sin ninguno
de los dos no habría a quién responder; el cliente no se pierde porque WhatsApp se
abre igual).

En los 5 formularios la llamada va **antes** de `window.open`, con
`fetch(..., {keepalive:true})`, en `try` y con `.catch()` vacío:
**fire-and-forget**, ningún fallo puede impedir que se abra WhatsApp.

Corregido de paso: **`js/form-tracking.js` era incacheable de por vida.** La regla
`immutable` de `vercel.json` lo servía con `max-age=31536000`; con un nombre sin
versionar, el tracker del PR #12 nunca se habría refrescado en un navegador que ya
lo tuviera. Ahora se carga como `?v=1`.

### PR #14 — Campos obligatorios, validación y prefijo internacional (14 ago)
`feat/form-required-fields-phone-prefix`. Los tres campos de contacto eran
opcionales y no se validaban: **se podía enviar la solicitud con «test» en email y
teléfono**, y el lead llegaba sin forma de contactar (y sin email, porque
`/api/lead` descarta los envíos sin vía de contacto).

- **Obligatorios y validados** en los 4 idiomas (`aria-required`, asterisco). El
  botón no envía nada si algo falla: ni `whatsapp_submit`, ni `/api/lead`, ni la
  apertura de WhatsApp. Error bajo el campo, en el idioma de la página, y foco al
  primer inválido. Email: `@` + dominio con TLD. Teléfono: mínimo 6 dígitos, solo
  dígitos, espacios y `().-`. Nombre: ≥2 caracteres con al menos una letra latina
  o cirílica. Tras el primer intento fallido, revalidación mientras se escribe.
- **Selector de prefijo sin librerías.** Nada de `intl-tel-input` ni imágenes de
  banderas: **54 países en una sola cadena** `"ISO,prefijo,nombre|…"` dentro del
  HTML, y la bandera se deriva del ISO con símbolos regionales Unicode. La lista
  se construye en el DOM la **primera vez que se abre**, no en la carga. Buscable
  por nombre (sin tildes también: «espan» → España), ISO o prefijo; teclado
  completo (↑↓, Enter, Esc). Nombres de país en el idioma de la página y ordenados
  alfabéticamente en ese idioma. Prefijo por defecto: ES +34 · EN +44 · FR +33 ·
  RU +7. Si el usuario pega el número en formato internacional, el prefijo se
  mueve al selector en vez de duplicarse.
- **Coste:** +3,8 KB gzip por página de reserva, **cero peticiones nuevas**,
  ~8 ms construir la lista, 0,05 ms filtrar por tecla, CLS 0,00. Lighthouse móvil
  sin cambios (a11y 96, buenas prácticas 100, SEO 100).
- **Bug colateral corregido: el campo de email quedaba en 54 px en móvil.** La
  rejilla usaba `grid-template-columns` en el `style` y `mobile.css` la forzaba a
  una columna con `!important`; como dos hijos llevaban `grid-column:span 2`, el
  navegador creaba una columna implícita. Ahora la rejilla tiene clase propia
  (`.bk-fields` / `.bk-full`) con su media query.

### PR #15 — Header móvil con selector de idioma por página (14 ago)
`fix/header-movil`. En ≤760 px los 4 idiomas se pliegan en un botón (`ES ▾`) que
abre un desplegable; en escritorio siguen en línea, y sin JavaScript también. Lo
importante: **cada enlace lleva a la traducción de esa misma página**, no a la
portada — y no se escribe a mano, **se genera desde los `hreflang`** de cada
página con `apply-lang-switcher.py` y se valida con `check-lang-switcher.py`. Una
página que no declara alternate para un idioma no ofrece ese idioma.

### PR #16 — `ESTADO.md` (14 ago)
`docs/estado-proyecto`. Documento vivo del estado del proyecto.

---

# 4. Configuración de herramientas externas

> **Sin claves ni tokens.** Nada de esto vive en el repo. Si un asistente te pide
> una API key, la respuesta es no: la única credencial del proyecto es una
> variable de entorno en Vercel.

## 4.1 Google Analytics 4

- Propiedad **`G-5FQ4F67XC4`**, cargada en todas las páginas.
- Eventos del embudo (los emite `js/form-tracking.js`, cargado en las homes y
  los 5 formularios; saca `lang` de `<html lang>`, así que separa el italiano solo):

| Evento | Cuándo | Dónde |
|---|---|---|
| `form_start` | Primera interacción con cualquier campo. Una vez por sesión y formulario (`sessionStorage`). | home + reservar |
| `form_progress` | Al llegar a un bloque. Una vez por paso y carga. Lleva `step`. | home + reservar |
| `form_continue` | Clic en «Ver disponibilidad» (éxito del widget de la home). | **solo home** |
| `whatsapp_submit` | Clic en «Solicitar reserva» — el envío real. | **solo reservar** |
| `form_abandon` | Al ocultarse la pestaña (`visibilitychange`/`pagehide`, vía `sendBeacon`) si hubo `form_start` sin éxito. Máx. uno por carga. Lleva `last_step` (el paso **más avanzado**, no el cronológicamente último). | home + reservar |

- Parámetros: `duration` (`2h`/`4h`/`8h`/`custom`), `guests` (1–10),
  `extras_count` (0–4, solo cuántos, nunca cuáles), `date_offset` (días hasta la
  salida; **se omite si aún no hay fecha**, para que un 0 signifique «hoy» y no
  «sin datos»), `form_location` (`home`/`reservar`), `lang`.
- **Las 8 dimensiones y métricas personalizadas ya están registradas:**

| Tipo | Nombre en GA4 | Parámetro |
|---|---|---|
| Dimensión (evento) | Paso del formulario | `step` |
| Dimensión (evento) | Último paso | `last_step` |
| Dimensión (evento) | Duración | `duration` |
| Dimensión (evento) | Ubicación del formulario | `form_location` |
| Dimensión (evento) | Idioma | `lang` |
| Métrica (evento) | Invitados | `guests` |
| Métrica (evento) | Nº de extras | `extras_count` |
| Métrica (evento) | Días hasta la salida | `date_offset` |

- ⚠️ **No hay retroactividad:** una definición personalizada solo recoge datos
  desde el momento de su alta.
- Cómo leerlo: `docs/GA4-embudo-reserva.md` (embudo de 7 pasos filtrado a
  `form_location=reservar`, embudo de 4 pasos para la home, y los cruces de
  abandono por duración / días hasta la salida / tamaño de grupo).

## 4.2 Resend (email de leads)

| Aspecto | Estado |
|---|---|
| Dominio | **Verificado** |
| Región | **Ireland (`eu-west-1`)** |
| Credencial | **`RESEND_API_KEY`**, variable de entorno en Vercel. Nunca en el repo, nunca en un log, nunca en una respuesta HTTP. |
| Remitente | `Rent Boat Marbella <reservas@rentboatmarbella.com>` |
| Destinatario | `info@rentboatmarbella.com` |
| `reply_to` | El email del cliente |
| Asunto | `Nueva solicitud de reserva — <nombre>, <fecha>` |
| Cuerpo | 11 campos: Nombre, Email, Teléfono, Fecha (dd/mm/aaaa), Duración, Invitados, Extras, Total estimado, Peticiones, Idioma, Página. **Siempre en español**: lo lee el propietario, no el cliente. |

## 4.3 Cookiebot

Banner de consentimiento en el `<head>` de todas las páginas.
**Sin consentimiento de estadísticas no hay GA4, por diseño:** Cookiebot bloquea
`gtag` y el código de medición no hace nada. **Las cifras de GA4 son de quien
acepta cookies, no del total de visitas.** Es el matiz más importante al
interpretar cualquier número.

## 4.4 Google Search Console

Propiedad **verificada**, **sitemap enviado con 100 URLs**. Es la fuente para las
tandas de indexación y para validar las correcciones de datos estructurados (p.
ej. el error de `Offer` sin `price` del PR #11, pendiente de marcar como
corregido).

## 4.5 Otras verificaciones

- **Bing** — verificado por `<meta name="msvalidate.01">` en el `<head>`.
- **Yandex** — verificado por `<meta name="yandex-verification">` (relevante: hay
  mercado ruso).

## 4.6 `robots.txt` — abierto a los bots de IA

```
User-agent: *            → Allow: /
User-agent: GPTBot       → Allow: /
User-agent: ClaudeBot    → Allow: /
User-agent: PerplexityBot→ Allow: /
User-agent: Google-Extended → Allow: /
Sitemap: https://www.rentboatmarbella.com/sitemap.xml
```

Decisión deliberada: se quiere aparecer en respuestas de asistentes de IA, no solo
en la SERP clásica.

---

# 5. Estado SEO **[ACTUALIZAR EN CADA REVISIÓN]**

> **Datos a fecha de 14 de agosto de 2026.** Esta sección es la que antes caduca.
> Antes de tomar cualquier decisión con ella, pide al propietario una captura
> fresca de Search Console (últimos 28 días: clics, impresiones, posición media,
> páginas indexadas) y **sustituye los valores** en vez de razonar sobre los
> viejos.

## 5.1 Cifras

| Métrica | Valor | Cómo obtenerla |
|---|---|---|
| URLs en el sitemap | **100** (verificado en el repo) | `grep -c "<loc>" sitemap.xml` |
| URLs indexadas | *[rellenar]* | GSC → Indexación → Páginas |
| Impresiones (28 d) | *[rellenar]* | GSC → Rendimiento |
| Clics (28 d) | *[rellenar]* | GSC → Rendimiento |
| Posición media | *[rellenar]* | GSC → Rendimiento |
| CTR medio | *[rellenar]* | GSC → Rendimiento |

## 5.2 Dónde rankea bien y dónde mal

- **Bien — larga cola, sobre todo FR y RU.** Consultas específicas y de intención
  clara (experiencia + idioma + lugar: aniversario en yate, pedida de mano,
  despedidas) entran en **top 10**. Es coherente con el trabajo hecho: landings de
  600–900 palabras con FAQPage y posts localizados de verdad, en mercados donde
  hay menos competencia escribiendo en ese idioma.
- **Mal — genéricas de cabecera.** «alquiler barco marbella», «boat rental
  marbella» y similares están alrededor de la **posición 70**. Ahí compiten
  marketplaces con miles de backlinks.

## 5.3 Diagnóstico de fondo

**La relevancia ya está conseguida; lo que falta es autoridad de dominio.**

El sitio está técnicamente sano (schema completo y validado, hreflang recíproco,
cero 404, cero huérfanas, WebP, a11y 96, sitemap limpio) y el contenido responde
bien a la intención: por eso gana la larga cola. Las genéricas no se ganan con más
HTML — se ganan con **señales externas**: enlaces y menciones, ficha de Google
Business activa y reseñas.

**Consecuencia práctica: el trabajo que más mueve la aguja ahora mismo no es de
código, es del propietario** (§7). Más posts o más schema tienen rendimiento
decreciente; la ficha de Google Business, las reseñas y las menciones de terceros
no.

---

# 6. Backlog

## 6.1 Técnico (schema e i18n)

1. **Unificar `LocalBusiness` y `Organization` con `@id`.** Hoy conviven dos
   entidades de la misma empresa sin relación declarada: `Organization` tiene
   `@id` (`…/#organization`) y `LocalBusiness` no tiene ninguno. Darle `@id` al
   `LocalBusiness` y enlazarlos (`parentOrganization` / `sameAs`) para que Google
   las lea como una sola entidad.
2. **Campo `url` en los 4 `Offer` corporativos.** Llevan `price`, `priceCurrency`
   y `availability`, pero no `url`. Recomendado por Google y barato.
3. **`hreflang` para los 2 posts sin traducción.** `post/boat-party-puerto-banus`
   (EN) y `post/bodas-eventos-barco-marbella` (ES) declaran un solo alternate. Se
   resuelve solo al traducirlos; mientras tanto son correctos como monolingües.
4. **Traducir a FR y RU los grupos que solo están en ES/EN.** Quedan tres del
   Paquete A: **licencia** (`necesitas-licencia-alquilar-barco-marbella` /
   `do-you-need-licence-rent-boat-marbella`), **Costa del Sol**
   (`alquiler-barco-costa-del-sol-puerto-banus` /
   `boat-rental-costa-del-sol-puerto-banus`) y los dos monolingües del punto
   anterior. **Mismo criterio que en agosto: localización, no traducción
   literal.**
5. **Fotos reales.** Varias páginas repiten las mismas imágenes. Sustituirlas por
   fotos propias del D50 mejora conversión y, de paso, da material para Google
   Business Profile.

De la etapa anterior siguen abiertos, con prioridad baja: **AVIF** y
`srcset`/`sizes` multi-ancho (la conversión a WebP ya capturó el mayor ahorro), y
el contraste del footer, único fallo de accesibilidad que queda.

## 6.2 Negocio y decisión (NO tocar hasta confirmación del propietario)

6. **Experimento de landing en alemán.** Solo **si los datos lo justifican**
   (tráfico DE real en Search Console / GA4). No abrir un quinto idioma por
   intuición.
7. **Posibles actividades nuevas:** **seabob**, **wakeboard / donut**, **parada en
   beach club por mar**, **tarjeta regalo**. Ninguna se publica hasta que exista
   como producto real y con precio confirmado — regla anti-invención (§8).
8. ~~**Qué lleva exactamente el catering del sunset.**~~ **RESUELTO** (19/08/2026):
   el sunset lleva el mismo catering que el resto de salidas; las 4 landings ya
   están corregidas. El alcohol incluido se limita a una botella de champán de
   cortesía (el propietario confirmó primero una copa y la subió a botella el mismo
   día). Ver §1.4.

---

# 7. Tareas del propietario (no son de código)

Por orden de impacto:

1. **🔴 Google Business Profile — PRIORIDAD Nº 1.** Falta la **verificación por
   vídeo del amarre**, que es lo que bloquea la ficha. Es la palanca más grande
   que queda para las búsquedas locales. Cuando exista la URL de la ficha, hay
   que añadirla al array `sameAs` del `LocalBusiness` (hoy solo está Instagram).
2. **Sistema de reseñas de Google.** Pedir reseña a **cada** cliente de forma
   sistemática, no ocasional. Es lo que más mueve la SERP local.
3. **Validar en Search Console** las correcciones de precio de las landings
   corporativas (PR #11): marcar el problema como corregido y esperar la
   revalidación.
4. **Tandas de indexación restantes.** Enviar a indexar las URLs nuevas o
   modificadas que aún no estén cubiertas.
5. **Menciones externas** — conserjerías de **hoteles de la Milla de Oro**,
   **wedding planners**, **fotógrafos de boda**, directorios náuticos y de turismo
   de la Costa del Sol. Esto es lo que ataca directamente el problema de autoridad
   de §5.3.
6. **Revisión mensual de métricas** — embudo de GA4 (dónde se cae la gente) +
   Search Console (qué consultas entran). Guía: `docs/GA4-embudo-reserva.md`.
7. **Vigilar la confusión de marca** con *rentalboatmarbella.com*.
8. **Datos aún no facilitados:** el **teléfono español +34** (hay un hueco `TODO`
   en el footer de las 100 páginas) y el **pantalán / número de amarre exacto**
   (mejora la SERP local y la coincidencia con Google Business).

---

# 8. Reglas y forma de trabajar

## 8.1 Reparto de papeles

**El asistente de IA de la conversación da estrategia SEO y de negocio, y prepara
prompts** que el propietario pega en **Claude Code**, que es quien toca el código
del repo. El asistente **no edita archivos directamente**: entrega el prompt
listo, con contexto suficiente y criterios de verificación.

De ahí que este documento incluya tanto detalle técnico: un prompt vago obliga a
Claude Code a redescubrir el proyecto y aumenta el riesgo de que invente datos.

## 8.2 Reglas duras (no negociables)

### 1. Anti-invención de datos comerciales

**Todo dato comercial en contenido nuevo — precios, duraciones, capacidades,
extras, qué incluye una tarifa — debe existir previamente en la home o en el
formulario de reserva.** Si no existe, se marca `[CONFIRMAR CON PROPIETARIO]` y
**no se publica**. Nunca se completa con cifras plausibles inventadas.

> **Por qué existe esta regla:** se publicó una **tarifa de 6 h que no existe**.
> Hubo que eliminarla de varias páginas y de los blogs FR/RU (PR #7). El dato era
> plausible — 2 h, 4 h, 8 h, ¿por qué no 6 h? — y por eso pasó desapercibido. Un
> dato comercial falso en una web de reservas es un problema con el cliente, no
> una errata.

Datos confirmados hoy: §1.3 (tarifas), §1.4 (qué incluye), §1.5 (extras), §1.1
(barco y capacidad).

### 2. La analítica nunca captura datos personales

El código de medición **no lee jamás el `.value`** de nombre, email, teléfono ni
peticiones especiales. Del bloque de contacto solo se registra **que hubo
interacción**. Esos datos viajan únicamente en el mensaje de WhatsApp que envía el
propio cliente y en el email de `/api/lead`. **Cualquier cambio en
`js/form-tracking.js` tiene que mantener esta propiedad**, y `test-booking-form.js`
lo verifica.

### 3. Versionar los assets al editarlos

`mobile.css` y los `.js` se sirven con `max-age=31536000, immutable`. **Al editar
uno de esos ficheros hay que subir el `?v=` de su etiqueta en todas las páginas
que lo cargan.** Si no, los visitantes recurrentes verán el HTML nuevo con el
asset viejo durante un año. Ya pasó con `form-tracking.js` (PR #13).

### 4. Anti-regresión: `check-links.sh` antes de cada push a `main`

**Si falla, no se hace push.** El blog se ha caído en producción dos veces (una
por commits sin pushear, otra por propagación de edge de Vercel); el script existe
por eso. Si además se han tocado páginas o `hreflang`, hay que pasar también
`check-lang-switcher.py`.

### 5. Verificar siempre en producción tras el deploy

Un servidor local no replica `cleanUrls`, y el Preview de Vercel puede llevar SSO.
Tras el deploy: `scripts/check-links.sh` contra producción (0 fallos esperados) y
comprobar lo que se haya tocado en vivo. **No dar nada por bueno sin haberlo visto
funcionando en el dominio real.**

### 6. Cada cambio en rama + Pull Request

Nunca directo a `main`. Rama descriptiva (`feat/...`, `fix/...`, `docs/...`),
commit con mensaje convencional en español, PR con el detalle de lo verificado, y
`check-links.sh` en verde.

## 8.3 Cómo se ha trabajado hasta ahora (y por qué funciona)

Patrón que se repite en todos los PR buenos y conviene mantener:

- **Verificar el hallazgo antes de corregirlo.** La auditoría externa (PR #10)
  traía 5 hallazgos; se comprobó cada uno contra el repo antes de tocar nada.
  Varios «errores» reportados en el PR #4 eran caché antigua, no bugs.
- **Buscar el alcance real, no el que se supone.** Antes de arreglar los `Offer`
  se parsearon los 332 bloques JSON-LD del sitio recorriendo el árbol completo,
  no un grep por fichero: se confirmó que eran exactamente 4 casos.
- **Decir qué NO se hace y por qué.** No redirigir `/flot`, no publicar precio por
  hora, no crear páginas por ciudad, no abrir un quinto idioma sin datos.
- **Dejar una salvaguarda tras cada incidente.** 404 del blog → `check-links.sh`.
  Posts huérfanos → fase 1 del mismo script. `Offer` sin precio →
  `check-offer-price.sh`. Fuga de datos a GA4 → prueba de cadenas canario en
  `test-booking-form.js`.
- **Medir el coste de lo que se añade.** El selector de prefijo se documentó con
  +3,8 KB gzip, 0 peticiones, ~8 ms y CLS 0,00, porque el sitio va a 88–99 en
  PageSpeed y eso se protege.

---

# 9. Resumen en 10 líneas (si solo lees esto)

1. Web de chárter privado de **un solo barco** (De Antonio D50, 15 m, 10 pax,
   patrón incluido) desde **Puerto Banús**, en **4 idiomas**.
2. **1.200 € / 2 h · 1.800 € / 4 h · 3.000 € / 8 h**, IVA incluido. No existe la
   tarifa de 6 h. No se publican precios por hora.
3. **HTML estático puro en Vercel**, sin build, 100 URLs, deploy automático desde
   `main` de `heyandreii/rentboatmarbella`.
4. Las reservas no se pagan online: el formulario abre **WhatsApp
   (+33 767126360)** y a la vez manda un email a **info@** vía `/api/lead`
   (Resend).
5. **PR #1–#16** cerraron lo crítico: 404 del blog, accesibilidad 58→96, schema
   completo y validado, formulario que perdía los datos de contacto, campos
   obligatorios y medición anónima del abandono.
6. Está medido en **GA4 (`G-5FQ4F67XC4`)** con embudo propio y 8 definiciones
   personalizadas, **sin capturar un solo dato personal**.
7. SEO: **relevancia conseguida** (larga cola FR/RU en top 10), **falta autoridad**
   (genéricas ~pos. 70). El cuello de botella ya no es técnico.
8. Lo que más mueve la aguja ahora es del propietario: **Google Business Profile
   (vídeo del amarre pendiente)**, reseñas y menciones externas.
9. Regla número uno: **nunca inventar un dato comercial.** Si no está en la home o
   en `/reservar`, se pregunta.
10. Todo cambio va en **rama + PR**, con `scripts/check-links.sh` en verde y
    verificado **en producción**.
