# Embudo de reserva en GA4 — guía de consulta

Propiedad **G-5FQ4F67XC4**. Los eventos los emite `js/form-tracking.js`, cargado
desde las 4 homes (`index`, `en`, `fr`, `ru`) y los 4 formularios de reserva
(`reservar`, `booking`, `reservation`, `zabronirovat`).

---

## 1. Qué se mide (y qué NO)

**Nunca sale del navegador** ningún dato de identidad: nombre, email, teléfono y
peticiones especiales no se leen jamás con `.value` desde el código de medición.
Del bloque de contacto solo se registra que el usuario *interactuó* con él.

Esos cuatro datos sí viajan, en cambio, en el mensaje de WhatsApp que el propio
cliente envía al pulsar «Solicitar reserva» — que es donde te sirven.

### Eventos

| Evento | Cuándo se dispara | Dónde |
|---|---|---|
| `form_start` | Primera interacción con cualquier campo. Una vez por sesión y por formulario (`sessionStorage`). | home + reservar |
| `form_progress` | Al llegar a un bloque. Una vez por paso y carga de página. | home + reservar |
| `form_continue` | Clic en «Ver disponibilidad» (el widget de la home no envía nada, solo lleva a /reservar). | **solo home** |
| `whatsapp_submit` | Clic en «Solicitar reserva» — el envío real. | **solo reservar** |
| `form_abandon` | Al salir de la página (`visibilitychange`→hidden o `pagehide`, vía `sendBeacon`) si hubo `form_start` sin evento de éxito. Máximo uno por carga de página. | home + reservar |

### Parámetros

`form_progress`, `form_continue`, `whatsapp_submit` y `form_abandon` llevan:

| Parámetro | Valores | Nota |
|---|---|---|
| `duration` | `2h` · `4h` · `8h` · `custom` | La home no tiene `custom`. |
| `guests` | 1–10 | Número entero. |
| `extras_count` | 0–4 | Solo cuántos, nunca cuáles. La home siempre 0 (no tiene extras). |
| `date_offset` | entero | Días entre hoy y la fecha elegida. **Se omite si aún no ha elegido fecha** — así un 0 significa «hoy», no «sin datos». |
| `form_location` | `home` · `reservar` | |
| `lang` | `es` · `en` · `fr` · `ru` | De `<html lang>`. |

Además: `form_progress` lleva `step` (`fecha`, `duracion`, `invitados`, `extras`,
`contacto`) y `form_abandon` lleva `last_step`, que es el paso **más avanzado**
alcanzado, no el cronológicamente último.

`form_start` solo lleva `form_location` y `lang`: cuando se dispara el usuario
todavía no ha configurado nada.

---

## 2. Configuración previa en GA4 (una sola vez, ~10 min)

Los parámetros personalizados **no aparecen en los informes hasta que los
registras**, y solo recogen datos **desde el momento en que los das de alta** —
no hay retroactividad. Hazlo antes de esperar resultados.

**Administrar → Presentación de datos → Definiciones personalizadas → Crear
dimensión personalizada.** Ámbito **Evento** en todas:

| Nombre | Parámetro del evento |
|---|---|
| Paso del formulario | `step` |
| Último paso | `last_step` |
| Duración | `duration` |
| Ubicación del formulario | `form_location` |
| Idioma | `lang` |

Y en **Crear métrica personalizada** (ámbito Evento, unidad Estándar):

| Nombre | Parámetro | |
|---|---|---|
| Invitados | `guests` | |
| Nº de extras | `extras_count` | |
| Días hasta la salida | `date_offset` | |

> `guests`, `extras_count` y `date_offset` son números: como **métrica** te dan
> medias y sumas; si además quieres *segmentar* por «reservas de 10 personas»
> tendrás que registrar `guests` también como dimensión (mismo parámetro, otro
> nombre, p. ej. «Invitados (grupo)»).

---

## 3. Dónde consultar los datos

### 3.1 DebugView — comprobar que algo funciona (tiempo real, solo tu navegador)

**Administrar → Depuración → DebugView.**

Para que tu navegación aparezca ahí necesitas: aceptar las cookies de
**estadísticas** en el banner de Cookiebot (sin eso `gtag` no existe y no se
envía nada, por diseño) y activar el modo de depuración con la extensión
[Google Analytics Debugger](https://chrome.google.com/webstore/detail/google-analytics-debugger/jnkmfdileelhofjcijamephohjechhna)
para Chrome.

Verás la secuencia de eventos en una línea temporal; al pulsar cada uno se
despliegan sus parámetros. Es la vía para confirmar una implementación, **no**
para analizar: solo muestra tu propio tráfico y de los últimos 30 minutos.

### 3.2 Tiempo real — ver que llega tráfico de verdad

**Informes → Tiempo real.** Baja hasta la tarjeta *Recuento de eventos por
nombre de evento*. Sirve para confirmar que los eventos llegan de usuarios
reales, no solo tuyos.

### 3.3 El embudo — el informe que vas a usar de verdad

**Explorar → Crear una exploración → Exploración de embudo.**

Configúralo así:

- **Pasos** (botón de editar junto a «Pasos»):
  1. `form_start`
  2. `form_progress` **con la condición** `step` = `fecha`
  3. `form_progress` con `step` = `duracion`
  4. `form_progress` con `step` = `invitados`
  5. `form_progress` con `step` = `extras`
  6. `form_progress` con `step` = `contacto`
  7. `whatsapp_submit`
- **Desglose**: arrastra *Ubicación del formulario* (`form_location`). Es
  imprescindible: la home solo tiene 3 pasos y siempre caerá a cero en «extras»
  y «contacto», así que mezclarla con /reservar en el mismo embudo da una lectura
  falsa. **Lo más práctico es hacer dos exploraciones separadas**, una filtrada a
  `form_location = reservar` (7 pasos) y otra a `form_location = home` (4 pasos,
  terminando en `form_continue` en vez de `whatsapp_submit`).
- **Mostrar el embudo transcurrido**: actívalo para ver cuánto tardan entre pasos.

Cómo se lee: cada barra es el % de usuarios que llegan a ese paso. **El escalón
donde más cae el porcentaje es tu problema.** Ejemplos de lectura:

- Caída fuerte en `contacto` → la gente configura el barco y se echa atrás al
  pedirle los datos. Problema de confianza o de fricción en el formulario.
- Caída fuerte en `duracion` → el precio asusta nada más verlo.
- `form_start` alto pero paso `fecha` bajo → tocan el widget sin intención real.

### 3.4 Abandonos vs envíos, de un vistazo

**Informes → Interacción → Eventos** te da el recuento bruto de cada evento.
La ratio que importa:

```
tasa de abandono = form_abandon / form_start
tasa de éxito    = whatsapp_submit / form_start   (en /reservar)
                   form_continue   / form_start   (en la home)
```

`form_abandon` + evento de éxito no siempre suman `form_start`: quien deja la
pestaña abierta y nunca la cierra no genera ninguno de los dos.

---

## 4. Qué configuraciones se pierden más

Aquí está el valor real de todo esto. **Explorar → Exploración de forma libre**:

- **Filtro**: `Nombre del evento` = `form_abandon`
- **Filas**: la dimensión que quieras investigar
- **Valores**: `Usuarios activos` (y, si procede, la media de la métrica)

Tres cruces que merecen la pena:

**a) ¿Qué duración pierde más gente?**
Filas = *Duración*. Compara con el mismo desglose sobre `whatsapp_submit`. Si
`8h` acumula muchos `form_abandon` y pocos `whatsapp_submit`, los 3.000€ están
frenando; si `custom` abandona mucho, la gente busca eventos y no encuentra
precio.

**b) ¿A qué distancia está la fecha que abandonan?**
Filas = *Último paso*, Valores = media de *Días hasta la salida*. Un
`date_offset` medio muy bajo (1–3 días) en los abandonos significa reservas de
última hora que no se atienden a tiempo — ahí la respuesta rápida es lo que
convierte. Un `date_offset` alto (60+) es gente planificando que solo está
mirando.

**c) ¿El tamaño del grupo?**
Filas = *Último paso*, Valores = media de *Invitados*. Si los abandonos tienen
media de invitados mucho más alta que los envíos, el tope de 10 personas o el
precio por grupo grande está estorbando.

**Cruce combinado:** Filas = *Duración*, Columnas = *Último paso*, Valores =
*Usuarios activos*, filtrado a `form_abandon`. Te da una tabla de «qué
configuración se cae en qué punto» — la vista más accionable de todas.

Añade siempre *Idioma* como segunda dimensión si sospechas que un mercado
concreto convierte peor.

---

## 5. Detalles que conviene saber al interpretar

- **Sin consentimiento de estadísticas no hay datos.** Cookiebot bloquea `gtag`,
  y el código de medición no hace nada. Tus cifras son de usuarios que aceptaron
  cookies, no del total de visitas.
- **`form_abandon` se dispara al ocultar la pestaña**, no solo al cerrarla. Quien
  cambia de pestaña y vuelve genera un abandono. Es el precio de que el evento
  llegue de forma fiable; se dispara como mucho una vez por carga de página.
- **Una misma sesión puede tener `form_abandon` y `whatsapp_submit`** si el
  usuario se fue y volvió. Si necesitas la cifra limpia, mide en *usuarios* y da
  prioridad al envío.
- **`form_start` es por sesión y formulario.** Volver a /reservar en la misma
  pestaña no vuelve a contarlo; los `form_progress` sí se repiten en cada carga.
