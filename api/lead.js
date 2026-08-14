/**
 * POST /api/lead — avisa por email de una solicitud de reserva.
 *
 * Se dispara a la vez que se abre WhatsApp, para no perder al cliente que está
 * en un ordenador sin WhatsApp Web. Es un extra: el cliente ya tiene su vía de
 * contacto abierta pase lo que pase aquí, así que esta función nunca debe
 * hacerle esperar ni romperle nada. El navegador la llama con `keepalive` y
 * descarta la respuesta.
 *
 * La API key sale SIEMPRE de process.env.RESEND_API_KEY. Nunca se escribe en el
 * repo, nunca se devuelve en una respuesta y nunca se escribe en un log.
 */

const RESEND_ENDPOINT = 'https://api.resend.com/emails';
const TO = 'info@rentboatmarbella.com';
const FROM = 'Rent Boat Marbella <reservas@rentboatmarbella.com>';

const MAX_BODY_BYTES = 8000;

// Tope de longitud por campo. Un formulario real nunca los roza; sirven para que
// nadie use el endpoint para inyectar un correo enorme.
const LIMITS = {
  name: 120, email: 160, phone: 60, date: 20, duration: 60,
  guests: 10, extras: 400, total: 40, notes: 1500, lang: 5, page: 80
};

// Etiquetas del correo. Se escribe siempre en español: lo lee el propietario,
// no el cliente. El idioma en el que rellenó el formulario va como un dato más.
const LABELS = {
  name: 'Nombre', email: 'Email', phone: 'Teléfono', date: 'Fecha',
  duration: 'Duración', guests: 'Invitados', extras: 'Extras',
  total: 'Total estimado', notes: 'Peticiones', lang: 'Idioma', page: 'Página'
};
const ORDER = ['name', 'email', 'phone', 'date', 'duration', 'guests', 'extras', 'total', 'notes', 'lang', 'page'];

/** Limitador por IP, best-effort: la memoria muere con la instancia y Vercel
 *  levanta varias, así que frena un bucle accidental, no un ataque decidido. El umbral
 *  va holgado: varios clientes reales pueden compartir IP tras un CGNAT. */
const hits = new Map();
const WINDOW_MS = 60000;
const MAX_PER_WINDOW = 10;

function rateLimited(ip) {
  const now = Date.now();
  for (const [k, v] of hits) if (now - v.first > WINDOW_MS) hits.delete(k);
  const e = hits.get(ip);
  if (!e) { hits.set(ip, { first: now, n: 1 }); return false; }
  if (now - e.first > WINDOW_MS) { hits.set(ip, { first: now, n: 1 }); return false; }
  e.n += 1;
  return e.n > MAX_PER_WINDOW;
}

function clean(value, max) {
  const s = typeof value === 'string' ? value : (value == null ? '' : String(value));
  // Fuera los caracteres de control salvo el salto de línea, que las peticiones
  // especiales sí pueden llevar. Evita cabeceras fabricadas y basura invisible.
  return s.replace(/[\u0000-\u0009\u000b-\u001f\u007f]+/g, ' ').trim().slice(0, max);
}

function esc(s) {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;')
          .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

/** dd/mm/aaaa a partir del aaaa-mm-dd del <input type="date"> */
function humanDate(iso) {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(iso);
  return m ? `${m[3]}/${m[2]}/${m[1]}` : iso;
}

module.exports = async function handler(req, res) {
  res.setHeader('Cache-Control', 'no-store');

  if (req.method !== 'POST') {
    res.setHeader('Allow', 'POST');
    return res.status(405).json({ ok: false, error: 'method_not_allowed' });
  }

  const ip = (req.headers['x-forwarded-for'] || '').split(',')[0].trim() || 'desconocida';
  if (rateLimited(ip)) return res.status(429).json({ ok: false, error: 'rate_limited' });

  let body = req.body;
  if (typeof body === 'string') {
    if (Buffer.byteLength(body, 'utf8') > MAX_BODY_BYTES) {
      return res.status(413).json({ ok: false, error: 'payload_too_large' });
    }
    try { body = JSON.parse(body); } catch (e) { body = null; }
  }
  if (!body || typeof body !== 'object') {
    return res.status(400).json({ ok: false, error: 'invalid_body' });
  }

  const data = {};
  for (const k of ORDER) data[k] = clean(body[k], LIMITS[k]);
  if (data.date) data.date = humanDate(data.date);

  // Sin email ni teléfono el aviso no sirve de nada: no habría a quién responder.
  // El cliente no se pierde — WhatsApp se le ha abierto igualmente.
  if (!data.email && !data.phone) {
    return res.status(422).json({ ok: false, error: 'sin_via_de_contacto' });
  }

  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) {
    console.error('[lead] falta RESEND_API_KEY en el entorno');
    return res.status(500).json({ ok: false, error: 'email_no_configurado' });
  }

  const filled = ORDER.filter((k) => data[k]);
  const subject = `Nueva solicitud de reserva — ${data.name || 'sin nombre'}, ${data.date || 'sin fecha'}`;

  const text = filled.map((k) => `${LABELS[k]}: ${data[k]}`).join('\n');
  const html =
    '<div style="font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;font-size:15px;color:#12232B;line-height:1.6">' +
    '<h2 style="font-size:18px;margin:0 0 16px">Nueva solicitud de reserva</h2>' +
    '<table cellpadding="0" cellspacing="0" style="border-collapse:collapse">' +
    filled.map((k) =>
      '<tr>' +
      `<td style="padding:6px 18px 6px 0;color:#626b6a;vertical-align:top;white-space:nowrap">${esc(LABELS[k])}</td>` +
      `<td style="padding:6px 0;font-weight:600">${esc(data[k]).replace(/\n/g, '<br>')}</td>` +
      '</tr>'
    ).join('') +
    '</table>' +
    '<p style="margin:20px 0 0;font-size:12.5px;color:#626b6a">Enviado automáticamente desde el formulario de reserva de rentboatmarbella.com.</p>' +
    '</div>';

  const payload = { from: FROM, to: [TO], subject, text, html };
  // Responder al correo va directo al cliente, sin copiar y pegar su dirección.
  if (data.email) payload.reply_to = data.email;

  try {
    const r = await fetch(RESEND_ENDPOINT, {
      method: 'POST',
      headers: { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });
    const out = await r.json().catch(() => ({}));
    if (!r.ok) {
      // se registra el motivo de Resend, jamás la credencial
      console.error('[lead] Resend respondió', r.status, out && out.message);
      return res.status(502).json({ ok: false, error: 'proveedor_email', status: r.status });
    }
    return res.status(200).json({ ok: true, id: out.id || null });
  } catch (err) {
    console.error('[lead] fallo al llamar a Resend:', err && err.message);
    return res.status(502).json({ ok: false, error: 'proveedor_email' });
  }
};
