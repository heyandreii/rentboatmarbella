# rentboatmarbella.com

Sitio estático (HTML) de alquiler de barco privado en Marbella (De Antonio D50).
Desplegado en **Vercel** desde la rama `main` de GitHub. Sin framework ni build:
los `.html` se sirven tal cual (con `cleanUrls: true`, ver `vercel.json`).

## Estructura

- `*.html` — páginas del sitio en 4 idiomas (ES/EN/FR/RU), URLs traducidas.
- `post/*.html` — artículos del blog (servidos como `/post/<slug>`).
- `img/` — imágenes (WebP + fallback JPG, con variantes responsivas `-640`/`-1280`).
- `vercel.json` — `cleanUrls`, `trailingSlash` y redirecciones 301.
- `robots.txt`, `sitemap.xml`.
- `scripts/check-links.sh` — comprobación anti-regresión de enlaces (ver abajo).

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
- **Incluido:** patrón, combustible de la ruta habitual e IVA.
- Formato de cifras por idioma: ES `1.200€` · EN `€1,200` · FR/RU `1 200 €`.
