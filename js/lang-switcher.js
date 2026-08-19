/* Selector de idioma del header — patrón "disclosure" (botón + panel).
 *
 * Desde el programa multiidioma el desplegable es el único modo, también en
 * escritorio: con 8 idiomas (ES EN FR RU IT NL DE AR) la fila en línea ya no
 * cabe en el header. mobile.css solo agranda el área táctil en ≤760px.
 *
 * El script marca el contenedor con data-js. Sin JS, mobile.css deja los
 * idiomas en línea (el comportamiento de siempre) en vez de esconderlos tras
 * un botón que nadie podría abrir.
 */
(function () {
  'use strict';

  function setup(root) {
    var btn = root.querySelector('[data-rbm-lang-btn]');
    var menu = root.querySelector('[data-rbm-lang-menu]');
    if (!btn || !menu) return;

    root.setAttribute('data-js', '');

    function open() {
      root.setAttribute('data-open', '');
      btn.setAttribute('aria-expanded', 'true');
      document.addEventListener('pointerdown', onOutside, true);
      document.addEventListener('keydown', onKeydown, true);
    }

    function close(returnFocus) {
      if (!root.hasAttribute('data-open')) return;
      root.removeAttribute('data-open');
      btn.setAttribute('aria-expanded', 'false');
      document.removeEventListener('pointerdown', onOutside, true);
      document.removeEventListener('keydown', onKeydown, true);
      if (returnFocus) btn.focus();
    }

    function onOutside(e) {
      if (!root.contains(e.target)) close(false);
    }

    function onKeydown(e) {
      if (e.key === 'Escape' || e.key === 'Esc') {
        e.preventDefault();
        close(true);
      }
    }

    btn.addEventListener('click', function () {
      if (root.hasAttribute('data-open')) {
        close(false);
        return;
      }
      open();
      // Foco al primer idioma distinto del actual: es lo que el usuario viene a pulsar.
      var first = menu.querySelector('a:not([aria-current])') || menu.querySelector('a');
      if (first) first.focus();
    });

    // Salir del panel con Tab equivale a un clic fuera.
    root.addEventListener('focusout', function (e) {
      if (e.relatedTarget && !root.contains(e.relatedTarget)) close(false);
    });

    // Girar el móvil o redimensionar la ventana recoloca el header; un panel
    // abierto se quedaría flotando fuera de sitio.
    window.addEventListener('resize', function () { close(false); });
  }

  /* El header es position:fixed y [data-nav-spacer] reserva su alto. Ese alto
   * no es fijo: depende de cuántas filas ocupe el header, y el ruso ("Забронировать")
   * ocupa bastante más que el resto. mobile.css ya lleva el valor del caso normal,
   * así que esto solo actúa cuando el header de verdad mide otra cosa — en el caso
   * habitual no cambia nada y no introduce CLS.
   */
  function syncSpacer() {
    var nav = document.querySelector('[data-rbm-nav]');
    var spacer = document.querySelector('[data-nav-spacer]');
    if (!nav || !spacer) return;
    var h = nav.getBoundingClientRect().height;
    // Umbral de 2px: los redondeos de siempre (69 declarado vs 68 real en
    // escritorio) no deben provocar un reflow.
    if (Math.abs(h - spacer.getBoundingClientRect().height) >= 2) {
      spacer.style.height = Math.ceil(h) + 'px';
    }
  }

  function boot() {
    var roots = document.querySelectorAll('[data-rbm-lang]');
    for (var i = 0; i < roots.length; i++) setup(roots[i]);

    syncSpacer();
    var nav = document.querySelector('[data-rbm-nav]');
    if (nav && window.ResizeObserver) new ResizeObserver(syncSpacer).observe(nav);
    else window.addEventListener('resize', syncSpacer);
    // Las webfonts cambian el ancho del CTA y pueden hacer saltar una fila.
    if (document.fonts && document.fonts.ready) document.fonts.ready.then(syncSpacer);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', boot);
  else boot();
})();
