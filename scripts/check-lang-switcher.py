#!/usr/bin/env python3
"""check-lang-switcher.py — salvaguarda del selector de idioma del header.

El selector de cada página se genera a partir de sus <link rel="alternate"
hreflang> (ver scripts/apply-lang-switcher.py). Este script comprueba, sin red,
que sigue cuadrando:

  1. Cada página tiene exactamente un selector.
  2. Cada enlace apunta a un fichero que existe en el repo.
  3. El destino está de verdad en el idioma que declara el enlace
     (su <html lang> coincide con el hreflang del <a>).
  4. Hay un único idioma marcado aria-current y es el de la página.
  5. Ese idioma activo enlaza a la propia página.

Sirve de red para las páginas nuevas: si se añade una traducción y no se
regenera el selector, esto falla en vez de dejar un enlazado a medias.

Uso:  scripts/check-lang-switcher.py
"""
import glob
import os
import re
import sys

ROOT = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else
                       os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))

SWITCHER = re.compile(r'<div data-rbm-lang\b.*?</div></div>', re.S)
# El dir="rtl" solo lo llevan los idiomas de escritura derecha-izquierda (árabe).
LINK = re.compile(r'<a href="([^"]+)" hreflang="([a-z]{2})" lang="([a-z]{2})" '
                  r'aria-label="[^"]+"( aria-current="true")?( dir="rtl")?')
HTML_LANG = re.compile(r'<html lang="([a-zA-Z-]+)"')
# Los 8 idiomas del programa multiidioma. Una página solo ofrece los que declara
# en sus hreflang, así que este conjunto es el techo, no lo esperado por página.
LANGS = ('es', 'en', 'fr', 'ru', 'it', 'nl', 'de', 'ar')
RTL = {'ar'}


def target_file(path):
    return 'index.html' if path == '/' else path.lstrip('/') + '.html'


def main():
    files = sorted(glob.glob(os.path.join(ROOT, '*.html')) +
                   glob.glob(os.path.join(ROOT, 'post', '*.html')))
    if not files:
        print('No se encontraron páginas en %s' % ROOT, file=sys.stderr)
        return 2

    lang_of, problems, total_links = {}, [], 0
    for f in files:
        m = HTML_LANG.search(open(f, encoding='utf-8').read())
        lang_of[os.path.relpath(f, ROOT)] = m.group(1).lower() if m else None

    for f in files:
        rel = os.path.relpath(f, ROOT)
        src = open(f, encoding='utf-8').read()

        found = SWITCHER.findall(src)
        if len(found) != 1:
            problems.append('%s: %d selectores (se esperaba 1)' % (rel, len(found)))
            continue

        links = LINK.findall(found[0])
        if not links:
            problems.append('%s: selector sin enlaces de idioma' % rel)
            continue

        current = [l for l in links if l[3]]
        if len(current) != 1:
            problems.append('%s: %d enlaces con aria-current (se esperaba 1)' % (rel, len(current)))
        elif current[0][1] != lang_of[rel]:
            problems.append('%s: aria-current en "%s" pero <html lang="%s">'
                            % (rel, current[0][1], lang_of[rel]))

        for href, hreflang, lang, is_current, rtl in links:
            total_links += 1
            if hreflang != lang:
                problems.append('%s: hreflang="%s" != lang="%s"' % (rel, hreflang, lang))
            if hreflang not in LANGS:
                problems.append('%s: idioma no registrado en el programa (%s)' % (rel, hreflang))
            if bool(rtl) != (hreflang in RTL):
                problems.append('%s: %s %s dir="rtl" (los RTL son: %s)'
                                % (rel, hreflang, 'no debería llevar' if rtl else 'debería llevar',
                                   ', '.join(sorted(RTL))))
            tgt = target_file(href)
            if not os.path.isfile(os.path.join(ROOT, tgt)):
                problems.append('%s: %s -> %s no existe' % (rel, hreflang, href))
                continue
            if lang_of.get(tgt) != hreflang:
                problems.append('%s: %s -> %s, pero esa página es lang="%s"'
                                % (rel, hreflang, href, lang_of.get(tgt)))
            if is_current and os.path.normpath(tgt) != os.path.normpath(rel):
                problems.append('%s: el idioma activo enlaza a %s, no a sí misma' % (rel, href))

    print('Páginas: %d · enlaces de idioma comprobados: %d' % (len(files), total_links))
    if problems:
        print('\n❌ Selector de idioma incoherente. NO hacer push a main.')
        for p in problems:
            print('  ' + p)
        print('\n   Regenera con: scripts/apply-lang-switcher.py')
        return 1
    print('✅ Todos los selectores de idioma cuadran con el hreflang de su página.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
