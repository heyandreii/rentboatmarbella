# rentboatmarbella.com

Sitio estático (HTML) de alquiler de barco privado en Marbella (De Antonio D50).
Desplegado en **Vercel** desde la rama `main` de GitHub. Sin framework ni build:
los `.html` se sirven tal cual (con `cleanUrls: true`, ver `vercel.json`).

> ¿Empiezas una conversación con una IA que no conoce el proyecto? Pégale
> [`docs/contexto-chat.md`](docs/contexto-chat.md): negocio, stack, historial de
> los PR #1–#16, configuración externa, estado y reglas, todo en un archivo.

## Estructura

- `*.html` — páginas del sitio en 4 idiomas (ES/EN/FR/RU), URLs traducidas.
- `post/*.html` — artículos del blog (servidos como `/post/<slug>`).
- `img/` — imágenes (WebP + fallback JPG, con variantes responsivas `-640`/`-768`/`-1280`;
  no todas tienen las tres: nunca se genera una variante más ancha que el original).
- `vercel.json` — `cleanUrls`, `trailingSlash` y redirecciones 301.
- `robots.txt`, `sitemap.xml`.
- `mobile.css` — ajustes responsive (se sirve `immutable` un año: **si lo tocas,
  sube el `?v=` del `<link>` en las 100 páginas** o los visitantes recurrentes
  verán el HTML nuevo con la CSS vieja).
- `js/lang-switcher.js` — desplegable de idioma del header en móvil.
- `scripts/check-links.sh` — comprobación anti-regresión de enlaces (ver abajo).
- `scripts/check-lang-switcher.py` — comprobación del selector de idioma (ver abajo).
- `scripts/apply-lang-switcher.py` — regenera el selector de idioma del header.
- `scripts/test-lead-api.js` — pruebas de `/api/lead` con Resend simulado (sin red).
- `scripts/test-booking-form.js` — pruebas del formulario de reserva de los 4
  idiomas: validación de nombre/email/teléfono y selector de prefijo. Ejecuta las
  reglas tal y como se sirven en el HTML. `node scripts/test-booking-form.js`.

## ⚠️ Antes de cada push a `main` (obligatorio)

Vercel despliega automáticamente cada push a `main`. Para evitar la regresión de
los 404 del blog (los `/post/...` se han caído en producción dos veces), ejecuta
**siempre** la comprobación de enlaces antes de hacer push:

```bash
# Contra producción (estado actual en vivo):
scripts/check-links.sh

# O contra un servidor local que sirva el repo (recomendado antes de push):
python3 -m http.server 8000 &          # sirve el repo en localhost:8000
scripts/check-links.sh http://127.0.0.1:8000
```

El script hace `curl` a todas las URLs internas enlazadas desde los índices del
blog (`/blog-nautico-marbella`, `/yacht-blog`, `/blog-nautique`, `/morskoy-blog`)
y **falla con exit 1 si alguna no responde 200**. Si falla, **no hagas push**.

> Nota: un servidor local (`python3 -m http.server`) **no** replica `cleanUrls`
> de Vercel, así que los `/post/<slug>` sin `.html` darán 404 en local aunque el
> archivo exista. Para validar rutas limpias, comprueba contra la URL de *Preview*
> de Vercel del PR, o contra producción tras el deploy.

Y, si has tocado páginas o `hreflang`, el selector de idioma del header
(offline, sin red):

```bash
scripts/check-lang-switcher.py
```

## Selector de idioma del header

Los enlaces ES/EN/FR/RU del header **no se escriben a mano**: se generan desde
los `<link rel="alternate" hreflang>` de cada página, así que cambiar de idioma
te deja en la traducción de *esa misma* página, no en la portada. Una página que
no declara alternate para un idioma no ofrece ese idioma (los posts que solo
existen en ES/EN muestran solo esos dos).

Al añadir una página o una traducción: pon bien sus `hreflang`, regenera con
`scripts/apply-lang-switcher.py` y valida con `scripts/check-lang-switcher.py`.
El validador falla si un enlace apunta a algo que no existe o a una página que
está en otro idioma del que dice.

En escritorio los 4 idiomas siguen en línea; en ≤760px se pliegan en un botón
(`ES ▾`) que abre un desplegable. Sin JavaScript se quedan en línea, como antes.

## Despliegue

`git push origin main` → Vercel despliega. Tras el deploy, verifica en producción:

```bash
scripts/check-links.sh                 # 0 fallos esperados
curl -sI https://www.rentboatmarbella.com/robots.txt | head -1
```

## Reglas para futuras sesiones

### Regla anti-invención de datos comerciales

**Cualquier dato comercial en contenido nuevo (precios, duraciones, capacidades, extras, qué incluye una tarifa) debe existir previamente en la home o el formulario de reserva. Si no existe, marcarlo como `[CONFIRMAR CON PROPIETARIO]` y no publicar hasta confirmación. Nunca completar con cifras plausibles inventadas.**

Referencia de datos confirmados a día de hoy (fuente: home + formulario `/reservar`):

- **Duraciones y tarifas:** 2 h → 1.200 € · 4 h → 1.800 € · 8 h (día completo) → 3.000 €. *(No existe tarifa de 6 h ni de 2.400 €.)*
- **Capacidad:** hasta **10** personas (por barco, no por persona).
- **Barco y motorización:** De Antonio D50, 15 m de eslora, año 2026, **2× Mercury V12 de 600 CV (total 1.200 CV)**. Formato por idioma: ES `2× Mercury V12 600 CV` · EN `2× Mercury V12 600 hp` · FR `2× Mercury V12 600 ch` · RU `2× Mercury V12 600 л.с.`
- **Incluido:** patrón, combustible de la ruta habitual, seguro, paddle surf, snorkel, **catering ligero** (fruta y frutos secos), **agua y refrescos**, **una copa de champán de cortesía** e IVA. *(Confirmado por el propietario el 19/08/2026.)* Redacción por idioma: ES `catering ligero, agua y refrescos, y copa de champán de cortesía` · EN `light catering, water and soft drinks, and a complimentary glass of champagne` · FR `catering léger, eau et sodas, et une coupe de champagne offerte` · RU `лёгкий кейтеринг, вода и напитки, и бокал шампанского в подарок`.
- **NO existe a bordo** (confirmado 19/08/2026, no publicar): equipo de sonido / Bluetooth, nevera, ducha de agua dulce, **colchoneta flotante** *(el único equipo de agua es el paddle surf)*. **No hay política de descorche**: no se promete subir bebida propia. **Alcohol incluido: solo la copa de champán de cortesía**; el resto de bebidas incluidas son sin alcohol (las botellas siguen siendo extra de pago). Los **globos** solo existen dentro del extra «decoración especial (+120 €)», nunca como incluido.
- **El sunset no lleva catering especial:** mismo catering ligero + agua y refrescos + copa de champán de cortesía que el resto de salidas (confirmado 19/08/2026).
- Formato de cifras por idioma: ES `1.200€` · EN `€1,200` · FR/RU `1 200 €`.
