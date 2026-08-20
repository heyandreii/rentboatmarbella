#!/usr/bin/env python3
"""Regenera el selector de idiomas del header (desplegable, todos los anchos).

Los destinos de cada página salen de sus propios <link rel="alternate" hreflang>,
así que el enlazado entre idiomas no se mantiene a mano. Una página que no
declara alternate para un idioma no ofrece ese idioma en su selector: por eso
las 130 páginas ES/EN/FR/RU siguen mostrando solo sus cuatro aunque el programa
multiidioma tenga ocho registrados aquí.

Además es el único sitio donde se decide la versión de los assets immutables
(mobile.css y js/lang-switcher.js): tocar CSS_V / JS_V y reejecutar propaga el
`?v=` a todas las páginas. Ver "Versionado de assets" en README.md.
"""
import glob
import os
import re
import sys

ROOT = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else '.')

# Versión de los assets servidos `immutable`. Subirlas aquí y reejecutar es lo
# que impide que un visitante recurrente vea el HTML nuevo con el asset viejo.
CSS_V = 4
JS_V = 2

# Orden de aparición en el panel. Los cuatro originales primero y las oleadas
# del programa multiidioma después, en el orden en que se abren: IT, NL, DE, AR.
ORDER = ['es', 'en', 'fr', 'ru', 'it', 'nl', 'de', 'ar']
CODE = {'es': 'ES', 'en': 'EN', 'fr': 'FR', 'ru': 'RU',
        'it': 'IT', 'nl': 'NL', 'de': 'DE', 'ar': 'AR'}
ENDONYM = {'es': 'Español', 'en': 'English', 'fr': 'Français', 'ru': 'Русский',
           'it': 'Italiano', 'nl': 'Nederlands', 'de': 'Deutsch', 'ar': 'العربية'}
# Idiomas de escritura derecha-izquierda. El panel se ancla con propiedades
# lógicas en mobile.css, pero el enlace al árabe desde una página LTR necesita
# su propio dir para que el endónimo no se rompa contra el texto de alrededor.
RTL = {'ar'}
# Fallback para las páginas que no declaran ningún alternate: portadas de idioma,
# que es exactamente lo que enlazaba el header antes de este cambio.
HOME = {'es': '/', 'en': '/en', 'fr': '/fr', 'ru': '/ru',
        'it': '/it', 'nl': '/nl', 'de': '/de', 'ar': '/ar'}
BTN_LABEL = {
    'es': 'Cambiar idioma. Idioma actual: Español',
    'en': 'Change language. Current language: English',
    'fr': 'Changer de langue. Langue actuelle : Français',
    'ru': 'Сменить язык. Текущий язык: Русский',
    'it': 'Cambia lingua. Lingua attuale: Italiano',
    'nl': 'Taal wijzigen. Huidige taal: Nederlands',
    'de': 'Sprache wechseln. Aktuelle Sprache: Deutsch',
    'ar': 'تغيير اللغة. اللغة الحالية: العربية',
}
ORIGIN = 'https://www.rentboatmarbella.com'
CHEVRON = ('<svg width="9" height="6" viewBox="0 0 9 6" aria-hidden="true" focusable="false" '
           'style="display:block"><path d="M1 1.5 4.5 5 8 1.5" fill="none" stroke="currentColor" '
           'stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>')

# Dos formas del selector, porque el script tiene que poder reejecutarse:
#   1) el bloque en línea original (páginas que aún no han pasado por aquí);
#   2) el desplegable que genera build().
# Sin la segunda alternativa el script no encontraba ningún selector en un repo
# ya migrado y fallaba con "0 selectores encontrados", así que era imposible
# regenerar el selector al añadir una traducción — que es justo para lo que
# existe. El patrón (2) es el mismo que usa check-lang-switcher.py.
SWITCHER = re.compile(
    r'<div style="display:flex;align-items:center;gap:2px;font-size:12px;font-weight:600;'
    r'color:#626b6a;letter-spacing:\.04em">.*?</div>'
    r'|<div data-rbm-lang\b.*?</div></div>', re.S)
ALTERNATE = re.compile(r'<link rel="alternate" hreflang="([a-zA-Z-]+)" href="([^"]+)"')
HTML_LANG = re.compile(r'<html lang="([a-zA-Z-]+)"')
CANONICAL = re.compile(r'<link rel="canonical" href="([^"]+)"')
# Acepta la etiqueta con o sin ?v= previo: la versión la fija este script.
CSS_TAG = re.compile(r'href="(/?)mobile\.css(?:\?v=\d+)?"')
JS_TAG = re.compile(r'src="(/?)js/lang-switcher\.js(?:\?v=\d+)?"')


def to_path(url):
    """URL absoluta del hreflang -> ruta interna tal y como enlaza el sitio."""
    if url.startswith(ORIGIN):
        path = url[len(ORIGIN):]
        return path if path else '/'
    return url


def target_file(path):
    """Ruta interna -> fichero del repo, para comprobar que el destino existe."""
    if path == '/':
        return 'index.html'
    return path.lstrip('/') + '.html'


def build(page_lang, langs):
    """langs: lista de (código, ruta) ya ordenada."""
    links = []
    for lang, path in langs:
        active = lang == page_lang
        color = '#3F7A72' if active else 'inherit'
        current = ' aria-current="true"' if active else ''
        rtl = ' dir="rtl"' if lang in RTL else ''
        links.append(
            '<a href="{path}" hreflang="{lang}" lang="{lang}" aria-label="{name}"{current}{rtl} '
            'style="color:{color};text-decoration:none;display:inline-block;padding:7px 6px">'
            '<span data-rbm-lang-code>{code}</span>'
            '<span data-rbm-lang-name>{name}</span></a>'.format(
                path=path, lang=lang, name=ENDONYM[lang], current=current, rtl=rtl,
                color=color, code=CODE[lang])
        )
    return (
        '<div data-rbm-lang style="position:relative;display:flex;align-items:center;'
        'font-size:12px;font-weight:600;color:#626b6a;letter-spacing:.04em">'
        '<button type="button" data-rbm-lang-btn aria-expanded="false" '
        'aria-controls="rbm-lang-menu" aria-label="{label}">{code}{chevron}</button>'
        '<div id="rbm-lang-menu" data-rbm-lang-menu style="display:flex;align-items:center;gap:2px">'
        '{links}</div></div>'
    ).format(label=BTN_LABEL[page_lang], code=CODE[page_lang], chevron=CHEVRON,
             links=''.join(links))


def main():
    files = sorted(glob.glob(os.path.join(ROOT, '*.html')) +
                   glob.glob(os.path.join(ROOT, 'post', '*.html')))
    errors, fallbacks, changed = [], [], 0

    for f in files:
        rel = os.path.relpath(f, ROOT)
        src = open(f, encoding='utf-8').read()

        m_lang = HTML_LANG.search(src)
        if not m_lang:
            errors.append('%s: sin <html lang>' % rel)
            continue
        page_lang = m_lang.group(1).lower()
        if page_lang not in ORDER:
            errors.append('%s: idioma no soportado (%s)' % (rel, page_lang))
            continue

        alts = {}
        for lang, url in ALTERNATE.findall(src):
            lang = lang.lower()
            if lang in ORDER:
                alts[lang] = to_path(url)

        if len(alts) < 2:
            # Página sin traducciones declaradas: sin fallback el selector se
            # quedaría con una sola opción y el usuario sin salida. Se ofrecen
            # las portadas de idioma (lo que enlazaba el header hasta ahora),
            # pero el idioma activo apunta a la propia página, no a su portada.
            # Solo las portadas que ya existen: las oleadas aún sin abrir no
            # deben aparecer como enlaces rotos.
            alts = {l: p for l, p in HOME.items()
                    if os.path.isfile(os.path.join(ROOT, target_file(p)))}
            m_canon = CANONICAL.search(src)
            if m_canon:
                alts[page_lang] = to_path(m_canon.group(1))
            fallbacks.append(rel)

        if page_lang not in alts:
            errors.append('%s: sus alternate no incluyen su propio idioma (%s)' % (rel, page_lang))
            continue

        for lang, path in alts.items():
            tf = os.path.join(ROOT, target_file(path))
            if not os.path.isfile(tf):
                errors.append('%s: destino %s (%s) no existe -> %s' % (rel, path, lang, target_file(path)))

        langs = [(l, alts[l]) for l in ORDER if l in alts]

        matches = SWITCHER.findall(src)
        if len(matches) != 1:
            errors.append('%s: %d selectores encontrados (se esperaba 1)' % (rel, len(matches)))
            continue

        out = src.replace(matches[0], build(page_lang, langs))

        # mobile.css y lang-switcher.js se sirven immutable durante un año: sin
        # bump de versión, un visitante con el asset viejo en caché vería el
        # HTML nuevo sin sus estilos o sin el desplegable.
        out = CSS_TAG.sub(r'href="\g<1>mobile.css?v=%d"' % CSS_V, out)

        if '/js/lang-switcher.js' not in out:
            out = out.replace(
                '</body>',
                '<script src="/js/lang-switcher.js?v=%d" defer></script>\n</body>' % JS_V, 1)
        else:
            out = JS_TAG.sub(r'src="\g<1>js/lang-switcher.js?v=%d"' % JS_V, out)

        if out != src:
            open(f, 'w', encoding='utf-8').write(out)
            changed += 1

    print('Páginas modificadas: %d / %d  ·  mobile.css?v=%d · lang-switcher.js?v=%d'
          % (changed, len(files), CSS_V, JS_V))
    if fallbacks:
        print('Fallback a portadas (sin alternate declarados): %s' % ', '.join(fallbacks))
    if errors:
        print('\nERRORES:')
        for e in errors:
            print('  ' + e)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
