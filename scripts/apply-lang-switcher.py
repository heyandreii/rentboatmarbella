#!/usr/bin/env python3
"""Convierte el selector de idiomas del header en un desplegable (móvil).

Los destinos de cada página salen de sus propios <link rel="alternate" hreflang>,
así que el enlazado entre idiomas no se mantiene a mano. Una página que no
declara alternate para un idioma no ofrece ese idioma en su selector.
"""
import glob
import os
import re
import sys

ROOT = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else '.')

ORDER = ['es', 'en', 'fr', 'ru']
CODE = {'es': 'ES', 'en': 'EN', 'fr': 'FR', 'ru': 'RU'}
ENDONYM = {'es': 'Español', 'en': 'English', 'fr': 'Français', 'ru': 'Русский'}
# Fallback para las páginas que no declaran ningún alternate: portadas de idioma,
# que es exactamente lo que enlazaba el header antes de este cambio.
HOME = {'es': '/', 'en': '/en', 'fr': '/fr', 'ru': '/ru'}
BTN_LABEL = {
    'es': 'Cambiar idioma. Idioma actual: Español',
    'en': 'Change language. Current language: English',
    'fr': 'Changer de langue. Langue actuelle : Français',
    'ru': 'Сменить язык. Текущий язык: Русский',
}
ORIGIN = 'https://www.rentboatmarbella.com'
CHEVRON = ('<svg width="9" height="6" viewBox="0 0 9 6" aria-hidden="true" focusable="false" '
           'style="display:block"><path d="M1 1.5 4.5 5 8 1.5" fill="none" stroke="currentColor" '
           'stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>')

# Dos formas del selector, porque el script tiene que poder reejecutarse:
#   1) el bloque en línea original (páginas que aún no han pasado por aquí);
#   2) el desplegable que genera build() (todas las páginas desde el PR #15).
# Sin la segunda alternativa el script no encontraba ningún selector en un repo
# ya migrado y fallaba con "0 selectores encontrados" en las 101 páginas, así que
# era imposible regenerar el selector al añadir una traducción — que es justo
# para lo que existe. El patrón (2) es el mismo que usa check-lang-switcher.py.
SWITCHER = re.compile(
    r'<div style="display:flex;align-items:center;gap:2px;font-size:12px;font-weight:600;'
    r'color:#626b6a;letter-spacing:\.04em">.*?</div>'
    r'|<div data-rbm-lang\b.*?</div></div>', re.S)
ALTERNATE = re.compile(r'<link rel="alternate" hreflang="([a-zA-Z-]+)" href="([^"]+)"')
HTML_LANG = re.compile(r'<html lang="([a-zA-Z-]+)"')
CANONICAL = re.compile(r'<link rel="canonical" href="([^"]+)"')


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
        links.append(
            '<a href="{path}" hreflang="{lang}" lang="{lang}" aria-label="{name}"{current} '
            'style="color:{color};text-decoration:none;display:inline-block;padding:7px 6px">'
            '{code}</a>'.format(path=path, lang=lang, name=ENDONYM[lang], current=current,
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
            alts = dict(HOME)
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

        # mobile.css se sirve immutable durante un año: sin bump de versión, un
        # visitante con la CSS vieja en caché vería el HTML nuevo sin sus estilos.
        out = out.replace('href="mobile.css"', 'href="mobile.css?v=2"')
        out = out.replace('href="/mobile.css"', 'href="/mobile.css?v=2"')

        if '/js/lang-switcher.js' not in out:
            out = out.replace(
                '</body>',
                '<script src="/js/lang-switcher.js?v=1" defer></script>\n</body>', 1)

        if out != src:
            open(f, 'w', encoding='utf-8').write(out)
            changed += 1

    print('Páginas modificadas: %d / %d' % (changed, len(files)))
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
