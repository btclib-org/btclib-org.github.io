#!/bin/sh
# The tree's copies of theme files are still the theme's.
#
# Two files here shadow files inside the jekyll-theme-minimal gem, a
# file of a given name in the tree taking precedence over the gem's:
#
#   _layouts/default.html    the layout, with fenced blocks added
#   assets/css/style.scss    the stylesheet, with rules appended
#
# Each is a fact about that gem recorded outside the gem, and the gem
# moves: Gemfile pins github-pages, github-pages pins the theme, and
# dependabot bumps that line. Nothing else here would notice a theme
# whose files changed underneath the copies -- the site would build green
# and serve the chrome of a release nobody runs any more, or half a
# stylesheet.
#
# So the copies are checked rather than trusted. They are checked
# differently because they are shaped differently: the layout's additions
# sit inside it and are fenced, so they are removed and the remainder
# compared; the stylesheet's are appended, so what is compared is the
# file's opening bytes.
#
# That needs the gems resolved, which is why this runs in website.yml and
# not in the lint gate, where uv is the only toolchain. Run from the
# repository root.
set -eu

GEM=jekyll-theme-minimal
LAYOUT=_layouts/default.html
STYLESHEET=assets/css/style.scss

# a fence, matched the same way in the count below and in the strip
# further down. The braces are written as bracket expressions because a
# brace is an interval in an extended regular expression and escaping one
# is left undefined by POSIX, where a bracket expression is not
BEGIN_RE='^[[:space:]]*([{]%- comment -%[}] )?btclib:begin'
END_RE='^[[:space:]]*([{]%- comment -%[}] )?btclib:end'

for f in "$LAYOUT" "$STYLESHEET"; do
    if [ ! -f "$f" ]; then
        echo "::error::no $f here: run this from the repository root"
        exit 1
    fi
done

gem_path=$(bundle info "$GEM" --path)
for f in "$LAYOUT" "$STYLESHEET"; do
    if [ ! -f "$gem_path/$f" ]; then
        echo "::error::the installed $GEM carries no $f"
        exit 1
    fi
done

status=0

# the fences are counted before they are used. A marker renamed on one
# side of a pair leaves a strip that removes half the file or none of it,
# and either of those reports below as a difference against the theme --
# which is the wrong finding, and the one a reader would chase into the
# gem rather than into this tree.
#
# What this cannot see is a block dropped whole, both its fences with it,
# which leaves the count even and the remainder equal to the gem's file.
# The layout's own header says how a block is carried across a theme
# upgrade for that reason: by grepping the copy being replaced for the
# marker, not by remembering a number
begins=$(grep -cE "$BEGIN_RE" "$LAYOUT" || true)
ends=$(grep -cE "$END_RE" "$LAYOUT" || true)
if [ "$begins" -lt 1 ] || [ "$begins" != "$ends" ]; then
    echo "::error::$LAYOUT has $begins begin fences and $ends end ones"
    exit 1
fi

# the end line is removed too: the test below it runs after the print,
# so the line that closes a block is still inside it
if ! awk "
    /$BEGIN_RE/ { skip = 1 }
    !skip       { print }
    /$END_RE/   { skip = 0 }
" "$LAYOUT" | diff -u "$gem_path/$LAYOUT" -; then
    echo "::error::$LAYOUT is not $GEM's layout plus its fenced blocks"
    echo "The diff above reads the gem's file as - and this tree's,"
    echo "stripped of its fenced blocks, as +."
    status=1
fi

# the stylesheet, by its opening bytes: this tree's file is the gem's
# with rules appended, so the gem's file is its prefix. cmp against a
# head of exactly that many bytes, which answers about the prefix and
# not about the additions
# the padding BSD wc writes is stripped: head refuses a byte count with
# a leading space, and the number is printed in the message below
n=$(wc -c < "$gem_path/$STYLESHEET" | tr -d '[:space:]')
if ! head -c "$n" "$STYLESHEET" | cmp - "$gem_path/$STYLESHEET"; then
    echo "::error::$STYLESHEET does not open with $GEM's own stylesheet"
    echo "cmp is above, reading this tree's first $n bytes on its"
    echo "standard input and the gem's file as the other operand: it"
    echo "names the first byte that differs, or reports the end of its"
    echo "input where this file is the shorter, and prints no diff"
    echo "either way. Where the theme is what moved, put its new"
    echo "stylesheet at the top of this one and leave the rules below."
    status=1
fi

if [ "$status" -ne 0 ]; then
    echo "::error::a theme file this tree copies no longer matches the gem"
fi
exit "$status"
