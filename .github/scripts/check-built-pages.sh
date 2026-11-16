#!/bin/sh
# Every built page passes a check for inline code and loads from elsewhere.
#
# The pages are held to
#
#   Content-Security-Policy: default-src 'self'; script-src 'self';
#     style-src 'self'; img-src 'self' data:; font-src 'self';
#     object-src 'none'; base-uri 'self'; form-action 'self';
#     frame-ancestors 'none'
#
# which refuses an inline script, an inline style, a `style` attribute,
# an event handler and a load from an origin it does not name. This check
# looks for those in the shapes listed below, and lets a `data:` image
# through as the policy does. It reads the built site, because the source
# can look clean and the theme's layout or stylesheet still emit one.
#
# btclib.org does not serve this policy. Its records are DNS only, so
# GitHub Pages answers, and Pages sets no Content-Security-Policy header.
# REPOSITORY.md's *Pages, which is btclib.org* says why the records are
# DNS only.
#
# The pages are held to the policy all the same, because a load from
# another origin sends that origin the visitor's address.
#
# Holding them to it also keeps them free of inline code, so a policy
# served for them would need no 'unsafe-inline'.
#
# What it reads, in every `*.html` under the site: an inline script or
# style element, a `style` attribute, an `on*` handler, a `javascript:`
# address, a form, and a `src`, `srcset`, `poster`, `data`, `href` or
# `xlink:href` that starts with `http://`, `https://` or `//`, in a
# double-quoted attribute, on an element `loaders` names or a `link` with
# a `rel` named below -- a plain `a` is a link a reader follows, and is
# not read.
#
# Two things the layout, which is the theme's, emits are not findings:
# HTML comments, which a browser never loads, and the JSON-LD block of
# `{% seo %}`, a data block that no browser runs.
#
# What it reads, in every `*.css` file under the site, a link to one
# included: a `url()` target, quoted or not, and a quoted string, as
# `@import` and `image-set()` take, that starts with `http://`,
# `https://` or `//`, in either case and after any leading space. A
# comment loads nothing and is not read. A `data:` target sends nothing
# to another origin and passes, a font's included, though the policy
# refuses a `data:` font. An escape is not decoded, so a load passes
# where one hides the prefix, as `\68ttps:` does, or hides `url` before
# an unquoted target, as `\75rl(` does. A stylesheet it cannot read is
# reported, and so is a directory it cannot list.
#
# A quoted string or a `url()` that loads nothing, as in an attribute
# selector, `content` or `@namespace`, is read all the same: a target
# there is reported as a load.
#
# Separately, `_config.yml`'s `projects` says which pages must exist, at
# the path `project_paths` gives where it gives one.
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
    $0 == "projects:"                    { seen = 1; next }
    seen && /^[A-Za-z]/                  { exit }
    seen && /^[[:space:]]*-[[:space:]]/  { print $2 }
' "$CONFIG")
if [ -z "$pages" ]; then
    echo "::error::$CONFIG has no projects list, or none this reads"
    exit 1
fi

# a project's page is its name, unless `project_paths` gives another
status=0
for project in $pages; do
    page=$(awk -v p="$project" '
        $0 == "project_paths:"               { seen = 1; next }
        seen && /^[A-Za-z]/                  { exit }
        seen && $1 == p ":"                  { print $2; found = 1; exit }
        END { if (!found) print p }
    ' "$CONFIG")
    if [ ! -s "$SITE/$page/index.html" ]; then
        echo "::error::$SITE/$page/index.html is not built"
        status=1
    fi
done

strip='s/<!--.*?-->//gs'
loaders='script|img|iframe|source|video|audio|track|embed|object|image|use|input|base'
foreign='[[:space:]](src|srcset|poster|data|href|xlink:href)="[[:space:]]*(https?:)?//'

# printf, not echo: a stylesheet's target can hold a backslash, which
# dash's echo reads as an escape
report() {
    printf '::error file=%s::%s\n' "$file" "$1"
    status=1
}

files=$(find "$SITE" -name '*.html' | sort)
if [ -z "$files" ]; then
    echo "::error::$SITE holds no html"
    exit 1
fi
for file in $files; do
    visible=$(perl -0777 -pe "$strip" "$file")
    tags=$(printf '%s' "$visible" | perl -0777 -ne 'while (/(<[a-zA-Z][^>]*>)/g) { (my $t = $1) =~ s/\s+/ /g; print "$t\n" }')
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

# -L, because the deploy archives the site with links followed, so a
# link to a stylesheet, or to a directory holding one, serves it. find
# runs apart from sort, whose pipe would hide its failure on a directory
# it cannot list, and with it what that directory holds
if ! sheets=$(find -L "$SITE" -name '*.css' -type f); then
    echo "::error::find cannot list every stylesheet under $SITE"
    exit 1
fi
sheets=$(printf '%s\n' "$sheets" | sort)
if [ -z "$sheets" ]; then
    echo "::error::$SITE holds no css"
    exit 1
fi
# here-documents, not a pipe, so that report sets this shell's status,
# and a read loop, so that a name is neither split nor globbed
while IFS= read -r file; do
    # each escape, comment, quoted string and unquoted url() target is
    # read whole, so that nothing inside one is read as another. A string
    # ends at its closing quote, at the end of the file, or before a line
    # break (CR, LF, FF or CRLF) that no backslash escapes; an unquoted
    # target ends at its `)`
    if ! targets=$(perl -0777 -e '
        open my $in, "<", $ARGV[0] or die "$ARGV[0]: $!\n";
        defined($_ = <$in>) or die "$ARGV[0]: $!\n";
        while (m{\\.|/\*.*?(?:\*/|\z)|"((?:[^"\\\n\r\f]|\\(?:\r\n|.|\z))*)(?:"|(?=[\n\r\f])|\z)|\x27((?:[^\x27\\\n\r\f]|\\(?:\r\n|.|\z))*)(?:\x27|(?=[\n\r\f])|\z)|url\(\s*([^"\x27\s)](?:[^)\\]|\\.)*)}gis) {
            my $t = $1 // $2 // $3 // "";
            print "$1\n" if $t =~ m{^\s*((?:https?:)?//\S*)}i;
        }' "$file"); then
        report "a stylesheet this check cannot read"
        continue
    fi
    while IFS= read -r target; do
        if [ -n "$target" ]; then
            report "a load from another origin: $target"
        fi
    done <<TARGETS
$targets
TARGETS
done <<SHEETS
$sheets
SHEETS
if [ "$status" -eq 0 ]; then
    echo "$SITE: no inline script or style, no handler, no load from another origin"
fi
exit "$status"
