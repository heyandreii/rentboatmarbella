/*!
 * form-tracking.js — medición anónima del embudo de reserva (GA4 G-5FQ4F67XC4)
 *
 * PRIVACIDAD — regla no negociable de este fichero:
 * este script NO lee jamás el .value de los campos de identidad (nombre, email,
 * teléfono, peticiones especiales). Solo escucha que hubo interacción con ellos.
 * Lo único que viaja a GA4 son datos de producto: duración, nº de invitados,
 * CUÁNTOS extras hay marcados (no cuáles) y la DISTANCIA EN DÍAS hasta la fecha
 * elegida (nunca la fecha literal). Cualquier cambio que envíe texto introducido
 * por el usuario infringe los Términos de Google Analytics y el RGPD.
 *
 * gtag() solo existe tras el consentimiento de estadísticas de Cookiebot; sin
 * consentimiento todas las llamadas de aquí son no-ops silenciosas.
 */
(function (w, d) {
  'use strict';

  var STEPS_ORDER = ['fecha', 'duracion', 'invitados', 'extras', 'contacto'];

  function send(name, params) {
    if (typeof w.gtag !== 'function') return; // sin consentimiento → no-op
    w.gtag('event', name, params);
  }

  /**
   * @param {Object} opts
   * @param {'home'|'reservar'} opts.location  valor de form_location
   * @param {function(): Object} opts.snapshot devuelve {duration, guests, extras_count, date_offset}
   * @param {string} opts.successEvent         'whatsapp_submit' | 'form_continue'
   */
  function create(opts) {
    var lang = (d.documentElement.getAttribute('lang') || 'es').slice(0, 2);
    var startKey = 'rbm_form_start_' + opts.location;
    var started = false;   // hubo form_start en esta carga de página
    var succeeded = false; // llegó al evento de éxito → ya no es abandono
    var abandonSent = false;
    var lastStep = '';   // paso MÁS AVANZADO alcanzado, no el cronológicamente último
    var seenSteps = {};  // un form_progress por paso y carga de página

    function base() {
      var s = opts.snapshot() || {};
      var p = {
        duration: s.duration,
        guests: s.guests,
        extras_count: s.extras_count,
        form_location: opts.location,
        lang: lang
      };
      // date_offset se omite si el usuario aún no ha elegido fecha,
      // en vez de mandar un 0 que se confundiría con "hoy".
      if (typeof s.date_offset === 'number' && isFinite(s.date_offset)) {
        p.date_offset = s.date_offset;
      }
      return p;
    }

    function start() {
      if (started) return;
      started = true;
      // "una sola vez por sesión y por formulario": sessionStorage sobrevive a
      // la navegación dentro de la pestaña, así que volver a /reservar no
      // vuelve a contar un inicio de formulario.
      try {
        if (w.sessionStorage.getItem(startKey)) return;
        w.sessionStorage.setItem(startKey, '1');
      } catch (e) { /* modo privado / storage bloqueado: se envía igualmente */ }
      send('form_start', { form_location: opts.location, lang: lang });
    }

    function progress(step) {
      start();
      if (STEPS_ORDER.indexOf(step) > STEPS_ORDER.indexOf(lastStep)) lastStep = step;
      // Un solo form_progress por paso: el embudo mide "llegó al paso", no
      // "cuántas veces lo tocó". Sin esto, cambiar de invitados cinco veces
      // inflaría el paso 'invitados' frente a los demás.
      if (seenSteps[step]) return;
      seenSteps[step] = true;
      var p = base();
      p.step = step;
      send('form_progress', p);
    }

    function success() {
      start();
      succeeded = true;
      var p = base();
      // El éxito también navega fuera (form_continue va a /reservar, el submit
      // abre wa.me), así que se envía por beacon para que no se pierda.
      p.transport_type = 'beacon';
      send(opts.successEvent, p);
    }

    function abandon() {
      if (!started || succeeded || abandonSent) return;
      abandonSent = true;
      var p = base();
      p.last_step = lastStep || 'ninguno';
      // transport_type:'beacon' hace que gtag.js use navigator.sendBeacon, la
      // única vía fiable cuando la página ya se está descargando.
      p.transport_type = 'beacon';
      send('form_abandon', p);
    }

    d.addEventListener('visibilitychange', function () {
      if (d.visibilityState === 'hidden') abandon();
    });
    w.addEventListener('pagehide', abandon);

    return { start: start, progress: progress, success: success };
  }

  /** Días enteros entre hoy y la fecha ISO elegida. Nunca se envía la fecha. */
  function dateOffset(isoDate) {
    if (!isoDate) return null;
    var parts = isoDate.split('-');
    if (parts.length !== 3) return null;
    var picked = Date.UTC(+parts[0], +parts[1] - 1, +parts[2]);
    var now = new Date();
    var today = Date.UTC(now.getFullYear(), now.getMonth(), now.getDate());
    if (isNaN(picked)) return null;
    return Math.round((picked - today) / 86400000);
  }

  /**
   * Pone el campo de fecha en blanco y su mínimo seleccionable en hoy, para que
   * nadie vea por defecto una fecha del pasado ni pueda elegirla.
   */
  function initDateField(el) {
    if (!el) return;
    var n = new Date();
    var iso = n.getFullYear() + '-' +
      ('0' + (n.getMonth() + 1)).slice(-2) + '-' +
      ('0' + n.getDate()).slice(-2);
    el.setAttribute('min', iso);
  }

  w.RBMTrack = { create: create, dateOffset: dateOffset, initDateField: initDateField };
})(window, document);
