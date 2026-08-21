// Pruebas del formulario de reserva de las 8 páginas (/reservar, /booking,
// /reservation, /zabronirovat, /prenota, /reserveren, /buchen, /hajz). No abre navegador ni red: lee los .html, extrae
// el bloque de validación REAL que se sirve al usuario (entre los marcadores
// [RBM-VALIDATION-START] y [RBM-VALIDATION-END]) y lo ejecuta, más una serie de
// comprobaciones estructurales sobre el marcado y el selector de prefijo.
//
//   node scripts/test-booking-form.js      (desde la raíz del repo)
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const PAGES = [
  { file: 'reservar.html', lang: 'es', dial: '+34', iso: 'ES', pais: 'Alemania', buscar: 'Buscar país' },
  { file: 'booking.html', lang: 'en', dial: '+44', iso: 'GB', pais: 'Germany', buscar: 'Search country' },
  { file: 'reservation.html', lang: 'fr', dial: '+33', iso: 'FR', pais: 'Allemagne', buscar: 'Rechercher un pays' },
  { file: 'zabronirovat.html', lang: 'ru', dial: '+7', iso: 'RU', pais: 'Германия', buscar: 'Поиск страны' },
  { file: 'prenota.html', lang: 'it', dial: '+39', iso: 'IT', pais: 'Germania', buscar: 'Cerca un paese' },
  { file: 'reserveren.html', lang: 'nl', dial: '+31', iso: 'NL', pais: 'Duitsland', buscar: 'Land zoeken' },
  { file: 'buchen.html', lang: 'de', dial: '+49', iso: 'DE', pais: 'Deutschland', buscar: 'Land suchen' },
  { file: 'hajz.html', lang: 'ar', dial: '+971', iso: 'AE', pais: 'ألمانيا', buscar: 'البحث عن دولة' }
];

let fallos = 0;
const ok = (cond, msg, extra) => {
  console.log((cond ? '  OK   ' : '  FALLO') + ' ' + msg + (extra !== undefined && !cond ? '  -> ' + JSON.stringify(extra) : ''));
  if (!cond) fallos++;
};

/** Saca del HTML el bloque de reglas de formato tal cual se sirve. */
function reglasDe(src, file) {
  const m = /\[RBM-VALIDATION-START\]([\s\S]*?)\/\* \[RBM-VALIDATION-END\] \*\//.exec(src);
  if (!m) throw new Error(`${file}: no encuentro el bloque [RBM-VALIDATION-*]`);
  const cuerpo = m[1].slice(m[1].indexOf('*/') + 2);
  return new Function(cuerpo + '\nreturn {vName:vName,vEmail:vEmail,vPhone:vPhone};')();
}

/** Reconstruye la lista de países del selector: "ISO,prefijo,nombre|..." */
function paisesDe(src, file) {
  const m = /"list":"([^"]+)"/.exec(src);
  if (!m) throw new Error(`${file}: no encuentro la lista de países`);
  return m[1].split('|').map((e) => {
    const p = e.split(',');
    return { iso: p[0], dial: p[1], name: p[2] };
  });
}

for (const pg of PAGES) {
  const src = fs.readFileSync(path.join(ROOT, pg.file), 'utf8');
  console.log(`\n=== ${pg.file} (${pg.lang}) ===`);

  // ---------------------------------------------------- reglas de formato --
  const { vName, vEmail, vPhone } = reglasDe(src, pg.file);

  ok(vEmail('ana@example.com') && vEmail('a.b-c@sub.dominio.co.uk'), 'email válido pasa');
  ['test', '', '   ', 'test@', '@dominio.com', 'test@dominio', 'a b@dominio.com', 'test@dominio.c']
    .forEach((v) => ok(!vEmail(v), `email rechazado: ${JSON.stringify(v)}`));

  ok(vPhone('600111222') && vPhone('600 11 12 22') && vPhone('(600) 111-222') && vPhone('+34600111222'),
    'teléfono válido pasa');
  ['test', '', '12345', '600 11', 'seis cero cero', '600111222x']
    .forEach((v) => ok(!vPhone(v), `teléfono rechazado: ${JSON.stringify(v)}`));

  ok(vName('Ana') && vName('Ли') && vName('Jo López'), 'nombre válido pasa');
  ['', 'A', ' A ', '12', '--']
    .forEach((v) => ok(!vName(v), `nombre rechazado: ${JSON.stringify(v)}`));

  // ------------------------------------------------------------- marcado --
  ['bk-name', 'bk-email', 'bk-phone', 'bk-cc-btn', 'bk-cc-q', 'bk-cc-list',
    'bk-err-name', 'bk-err-email', 'bk-err-phone'].forEach((id) =>
      ok(src.includes(`id="${id}"`), `existe #${id}`));

  ['bk-name', 'bk-email', 'bk-phone'].forEach((id) => {
    const tag = new RegExp(`<input id="${id}"[^>]*>`).exec(src);
    ok(!!tag && /aria-required="true"/.test(tag[0]), `#${id} marcado como obligatorio`);
    ok(!!tag && /placeholder="[^"]*\*"/.test(tag[0]), `#${id} lleva el asterisco de obligatorio`);
  });
  ok(!/id="bk-notes"[^>]*aria-required/.test(src), '#bk-notes sigue siendo opcional');

  // -------------------------------------------------- selector de prefijo --
  const paises = paisesDe(src, pg.file);
  ok(paises.length >= 40 && paises.length <= 60, `${paises.length} países en la lista`, paises.length);
  ok(paises.every((c) => /^[A-Z]{2}$/.test(c.iso)), 'todos los ISO son de 2 letras');
  ok(paises.every((c) => /^[0-9]{1,4}$/.test(c.dial)), 'todos los prefijos son numéricos');
  ok(paises.every((c) => c.name && c.name.trim().length > 1), 'todos los países tienen nombre');
  ok(new Set(paises.map((c) => c.iso)).size === paises.length, 'sin países duplicados');

  const def = /"def":"([A-Z]{2})"/.exec(src);
  ok(!!def && def[1] === pg.iso, `prefijo por defecto ${pg.iso}`, def && def[1]);
  const defPais = paises.find((c) => c.iso === pg.iso);
  ok(!!defPais && '+' + defPais.dial === pg.dial, `el país por defecto marca ${pg.dial}`, defPais);
  ok(src.includes(`<span id="bk-cc-dial">${pg.dial}</span>`), `el botón muestra ${pg.dial} sin esperar al JS`);

  // Nombres de país en el idioma de la página (una muestra por idioma).
  ok(paises.some((c) => c.iso === 'DE' && c.name === pg.pais), `Alemania se llama "${pg.pais}"`,
    paises.find((c) => c.iso === 'DE'));
  ok(src.includes(`placeholder="${pg.buscar}"`), `el buscador dice "${pg.buscar}"`);

  // Orden alfabético en el idioma de la página: el usuario recorre la lista.
  const ordenada = paises.map((c) => c.name).slice().sort((a, b) => a.localeCompare(b, pg.lang));
  ok(JSON.stringify(ordenada) === JSON.stringify(paises.map((c) => c.name)),
    'lista ordenada alfabéticamente en el idioma de la página');

  // Mercados que no pueden faltar.
  ['ES', 'GB', 'FR', 'DE', 'RU', 'US', 'AE', 'SA', 'NL', 'IT', 'PT', 'CH', 'BE', 'SE', 'NO', 'PL', 'CA']
    .forEach((iso) => ok(paises.some((c) => c.iso === iso), `incluye ${iso}`));

  // ------------------------------------------- disparo solo si es válido ---
  const submit = src.slice(src.indexOf("submit.addEventListener('click'"));
  const iValidate = submit.indexOf('if(!validate())return;');
  const iSuccess = submit.indexOf('track.success()');
  const iFetch = submit.indexOf("fetch('/api/lead'");
  const iOpen = submit.indexOf('window.open(');
  ok(iValidate > -1, 'el submit valida antes de nada');
  ok(iValidate < iSuccess, 'whatsapp_submit (track.success) va DESPUÉS de validar');
  ok(iValidate < iFetch, '/api/lead se llama DESPUÉS de validar');
  ok(iValidate < iOpen, 'WhatsApp se abre DESPUÉS de validar');

  // ------------------------------- el teléfono viaja completo a los dos ----
  ok(/var tel=fullPhone\(\);/.test(submit), 'el teléfono se compone con prefijo + número');
  // AR envuelve el teléfono con lrm() en el mensaje de WhatsApp (marca RTL invisible
  // para que el número no se descoloque entre texto árabe); el resto de idiomas lo
  // manda tal cual.
  ok(/\[CFG\.msg\.phone,(?:lrm\(tel\)|tel)\]/.test(submit), 'WhatsApp recibe el teléfono con prefijo');
  ok(/phone:tel,/.test(submit), '/api/lead recibe el teléfono con prefijo');
  ok(!/phone:phoneEl/.test(submit), 'ya no se manda el número suelto sin prefijo');

  // ------------------------------------------------------- privacidad GA4 --
  const tracking = src.slice(src.indexOf('window.RBMTrack'), src.indexOf("submit.addEventListener('click'"));
  ok(!/track\.(progress|success)\([^)]*\.value/.test(src), 'GA4 no recibe ningún valor tecleado');
  ok(tracking.includes("track.progress('contacto')"), 'se sigue midiendo el paso "contacto"');
}

console.log(fallos === 0 ? '\nTodo correcto.' : `\n${fallos} fallo(s).`);
process.exit(fallos === 0 ? 0 : 1);
