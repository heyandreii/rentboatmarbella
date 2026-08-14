// Pruebas del handler /api/lead con Resend simulado. No sale nada a la red y no
// hace falta ninguna credencial real.
//
//   node scripts/test-lead-api.js      (desde la raíz del repo)
const handler = require('../api/lead.js');

let captured = null;
let nextResponse = { ok: true, status: 200, json: async () => ({ id: 'fake-id-123' }) };
global.fetch = async (url, opts) => { captured = { url, opts }; return nextResponse; };

function mkRes() {
  const r = { statusCode: null, body: null, headers: {} };
  r.setHeader = (k, v) => { r.headers[k] = v; };
  r.status = (c) => { r.statusCode = c; return r; };
  r.json = (b) => { r.body = b; return r; };
  return r;
}
let ipSeq = 0;
const call = async (req) => {
  if (!req.headers['x-forwarded-for']) req.headers['x-forwarded-for'] = '10.0.0.' + (++ipSeq);
  const res = mkRes(); await handler(req, res); return res;
};

const LEAD = {
  name: 'Ana López', email: 'ana@example.com', phone: '+34 600 111 222',
  date: '2026-09-01', duration: '4 horas', guests: '10',
  extras: 'Moto de agua, Decoración especial', total: '2.170€',
  notes: 'Cumpleaños sorpresa', lang: 'es', page: '/reservar'
};

let fallos = 0;
const ok = (cond, msg, extra) => {
  console.log((cond ? '  OK   ' : '  FALLO') + ' ' + msg + (extra !== undefined && !cond ? '  -> ' + JSON.stringify(extra) : ''));
  if (!cond) fallos++;
};

(async () => {
  process.env.RESEND_API_KEY = 'clave-de-prueba-no-real';

  console.log('\n1. Lead completo');
  captured = null;
  let res = await call({ method: 'POST', headers: {}, body: LEAD });
  ok(res.statusCode === 200, 'responde 200', res.body);
  ok(res.body.ok === true && res.body.id === 'fake-id-123', 'devuelve el id de Resend', res.body);
  const sent = JSON.parse(captured.opts.body);
  ok(captured.url === 'https://api.resend.com/emails', 'llama al endpoint de Resend');
  ok(captured.opts.headers.Authorization === 'Bearer clave-de-prueba-no-real', 'manda la key por cabecera');
  ok(sent.subject === 'Nueva solicitud de reserva — Ana López, 01/09/2026', 'asunto correcto', sent.subject);
  ok(sent.to[0] === 'info@rentboatmarbella.com', 'destinatario info@');
  ok(/@rentboatmarbella\.com>$/.test(sent.from), 'from usa el dominio propio', sent.from);
  ok(sent.reply_to === 'ana@example.com', 'reply_to al cliente');
  const faltan = ['Ana López', 'ana@example.com', '+34 600 111 222', '01/09/2026', '4 horas',
                  '10', 'Moto de agua', '2.170€', 'Cumpleaños sorpresa', 'es', '/reservar']
                 .filter((v) => !sent.text.includes(v));
  ok(faltan.length === 0, 'los 11 campos aparecen en el cuerpo', faltan);
  console.log('\n--- texto del email ---\n' + sent.text + '\n-----------------------');

  console.log('\n2. Guardas');
  res = await call({ method: 'GET', headers: {} });
  ok(res.statusCode === 405, 'GET -> 405', res.statusCode);
  res = await call({ method: 'POST', headers: {}, body: { name: 'X' } });
  ok(res.statusCode === 422, 'sin email ni telefono -> 422', res.statusCode);
  res = await call({ method: 'POST', headers: {}, body: 'no-es-json' });
  ok(res.statusCode === 400, 'cuerpo invalido -> 400', res.statusCode);
  res = await call({ method: 'POST', headers: {}, body: 'x'.repeat(9000) });
  ok(res.statusCode === 413, 'cuerpo enorme -> 413', res.statusCode);

  console.log('\n3. La credencial nunca sale al cliente');
  captured = null;
  nextResponse = { ok: false, status: 401, json: async () => ({ message: 'API key is invalid' }) };
  res = await call({ method: 'POST', headers: {}, body: LEAD });
  ok(res.statusCode === 502, 'Resend falla -> 502', res.statusCode);
  ok(!JSON.stringify(res.body).includes('clave-de-prueba-no-real'), 'la key no viaja en la respuesta', res.body);
  nextResponse = { ok: true, status: 200, json: async () => ({ id: 'fake-id-123' }) };

  delete process.env.RESEND_API_KEY;
  res = await call({ method: 'POST', headers: {}, body: LEAD });
  ok(res.statusCode === 500 && res.body.error === 'email_no_configurado', 'sin RESEND_API_KEY -> 500 claro', res.body);
  process.env.RESEND_API_KEY = 'clave-de-prueba-no-real';

  console.log('\n4. Inyeccion de HTML y de cabeceras');
  captured = null;
  await call({ method: 'POST', headers: {}, body: {
    name: '<img src=x onerror=alert(1)>', email: 'x@y.com',
    notes: 'linea1\nlinea2', phone: 'tel\r\nBcc: victima@ejemplo.com'
  }});
  const s2 = JSON.parse(captured.opts.body);
  ok(!s2.html.includes('<img'), 'el HTML del atacante va escapado', s2.html.slice(0, 200));
  ok(s2.html.includes('&lt;img'), 'escapado como entidades');
  ok(!s2.text.includes('\r'), 'los retornos de carro se limpian del telefono');
  ok(s2.text.includes('linea1\nlinea2'), 'el salto de linea real de las peticiones se conserva');

  console.log('\n5. Limite de peticiones por IP');
  let codes = [];
  for (let i = 0; i < 13; i++) {
    const r = await call({ method: 'POST', headers: { 'x-forwarded-for': '1.2.3.4' }, body: LEAD });
    codes.push(r.statusCode);
  }
  ok(codes.filter((c) => c === 429).length >= 2, 'a partir de 10/min corta con 429', codes);
  const otra = await call({ method: 'POST', headers: { 'x-forwarded-for': '9.9.9.9' }, body: LEAD });
  ok(otra.statusCode === 200, 'otra IP no queda afectada', otra.statusCode);

  console.log('\n' + (fallos === 0 ? 'TODO OK — 0 fallos' : fallos + ' FALLOS'));
  process.exit(fallos === 0 ? 0 : 1);
})();
