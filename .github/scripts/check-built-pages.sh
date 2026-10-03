#!/bin/sh
# Every built page holds under a check that allows same-origin loads only.
#
# btclib.org may be served with
#
#   Content-Security-Policy: default-src 'self'; script-src 'self'
#     https://cdnjs.cloudflare.com; style-src 'self'; img-src 'self' data:;
#     font-src 'self'; object-src 'none'; base-uri 'self';
#     form-action 'self'; frame-ancestors 'none'
#
# which refuses an inline script, an inline style, a `style` attribute,
# an event handler and a load from an origin it does not name. This check
# is stricter than the policy: it refuses every load from another origin,
# where the policy also admits scripts from cdnjs.cloudflare.com and
# `data:` images. It reads the built HTML, because the page source can
# look clean and the layout still emit one.
#
# What it reads, in every `*.html` under the site: an inline script or
# style element, a `style` attribute, an `on*` handler, a `javascript:`
# address, a form, and a `src`, `srcset`, `poster`, `data` or `href` that
# starts with a scheme or `//` on an element that loads something or sets
# a `base` -- a plain `a` is a link a reader follows, and is not read.
#
# Two things the layout, which is the theme's, emits are not findings:
# HTML comments, which a browser never loads -- the theme's IE 9 shim
# is inside one -- and the JSON-LD block of `{% seo %}`, a data block
# that no browser runs.
#
# Separately, `_config.yml`'s `project_pages` says which pages must exist.
#
# Usage: check-built-pages.sh [site-directory]  (default _site)
set -eu

SITE=${1:-_site}
CONFIG=_config.yml

if [ ! -f "$CONFIG" ] || [ ! -d "$SITE" ]; then
    echo "::error::run this from the repository root, after the build"
    exit 1
fi

pages=$(awk '
    $0 == "project_pages:"               { seen = 1; next }
    seen && /^[A-Za-z]/                  { exit }
    seen && /^[[:space:]]*-[[:space:]]/  { print $2 }
' "$CONFIG")
if [ -z "$pages" ]; then
    echo "::error::$CONFIG has no project_pages list, or none this reads"
    exit 1
fi

status=0
for page in $pages; do
    if [ ! -s "$SITE/$page/index.html" ]; then
        echo "::error::$SITE/$page/index.html is not built"
        status=1
    fi
done

strip='s/<!--.*?-->//gs'
loaders='script|img|iframe|source|video|audio|track|embed|object|image|use|input|base'
foreign='[[:space:]](src|srcset|poster|data|href|xlink:href)="[[:space:]]*(https?:)?//'

files=$(find "$SITE" -name '*.html' | sort)
if [ -z "$files" ]; then
    echo "::error::$SITE holds no html"
    exit 1
fi
for file in $files; do
    visible=$(perl -0777 -pe "$strip" "$file")
    tags=$(printf '%s' "$visible" | perl -0777 -ne 'while (/(<[a-zA-Z][^>]*>)/g) { (my $t = $1) =~ s/\s+/ /g; print "$t\n" }')
    report() {
        echo "::error file=$file::$1"
        status=1
    }
    printf '%s\n' "$tags" | grep -iE '^<script' | grep -ivE ' src=|type="application/ld\+json"' \
        | grep -q . && report "an inline script"
    printf '%s' "$visible" | grep -qiE '<style' && report "an inline style element"
    printf '%s\n' "$tags" | grep -qiE '[[:space:]]style=' && report "a style attribute"
    printf '%s\n' "$tags" | grep -qiE '[[:space:]]on[a-z]+=' && report "an event handler"
    printf '%s\n' "$tags" | grep -qiE '(href|src|action)="[[:space:]]*javascript:' \
        && report "a javascript: address"
    # a `link` loads only for these rels: canonical and alternate do not
    {
        printf '%s\n' "$tags" | grep -iE "^<($loaders)[[:space:]]" || true
        printf '%s\n' "$tags" | grep -iE '^<link[[:space:]].*rel="[^"]*(stylesheet|icon|preload|manifest)' || true
    } | grep -iE "$foreign" | grep -q . && report "a load from another origin"
    printf '%s\n' "$tags" | grep -iE '^<form[[:space:]]' | grep -q . && report "a form"
done
if [ "$status" -eq 0 ]; then
    echo "$SITE: no inline script or style, no handler, no load from another origin"
fi
exit "$status"
