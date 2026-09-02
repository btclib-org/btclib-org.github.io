#!/bin/sh
# _config.yml's projects list is the set of repositories index.md links.
#
# The sidebar's list of projects is written in _config.yml; the page's
# body, which names the same repositories at length, is index.md, and
# index.md is generated from btclib-org/.github's profile/README.md. So
# the two live in different trees, and the day the organization gains a
# repository the body gains it upstream while the list here does not.
# Neither file fails on its own for that: the site builds, the sidebar is
# short by one, and the page disagrees with itself in a way only a reader
# comparing two columns would see.
#
# This is what refuses it. The addresses are read out of the rendered
# body rather than out of the organization's API, so the check needs no
# token and no network, and so that what it compares is the two things a
# visitor actually sees.
#
# Run from the repository root.
set -eu

CONFIG=_config.yml
HOMEPAGE=index.md

for f in "$CONFIG" "$HOMEPAGE"; do
    if [ ! -f "$f" ]; then
        echo "::error::no $f here: run this from the repository root"
        exit 1
    fi
done

# every btclib-org address the body carries, reduced to the repository
# name. Addresses of other organizations are left out by the prefix --
# the body links bitcoin-core/secp256k1 among others -- and sort -u makes
# a set of what is a list of links, a repository being linked more than
# once without that meaning anything.
#
# A name may hold a dot, `.github` and btclib-org.github.io both being
# repositories here, but may not end in one: this file is generated from
# prose, and a bare address closing a sentence would otherwise carry that
# sentence's full stop into the name
linked=$(grep -oE 'https://github\.com/btclib-org/[A-Za-z0-9._-]*[A-Za-z0-9_-]' \
    "$HOMEPAGE" | sed 's|.*/||' | sort -u)

# the list itself, from the key to the first top-level key after it. An
# entry is an indented dash; the comment block that follows the list is
# skipped by the same rule, a comment not being an entry
listed=$(awk '
    $0 == "projects:"            { seen = 1; next }
    seen && /^[A-Za-z]/          { exit }
    seen && /^[[:space:]]*-[[:space:]]/ { print $2 }
' "$CONFIG" | sort -u)

# both halves proved non-empty before they are compared: a key renamed
# here or a link style changed upstream would otherwise make two empty
# sets, which compare equal and report a tree in agreement with itself
if [ -z "$linked" ]; then
    echo "::error::$HOMEPAGE links no github.com/btclib-org address"
    exit 1
fi
if [ -z "$listed" ]; then
    echo "::error::$CONFIG has no projects list, or none this reads"
    exit 1
fi

if [ "$linked" = "$listed" ]; then
    exit 0
fi

echo "::error::$CONFIG's projects are not the repositories $HOMEPAGE links"
echo "$HOMEPAGE links:"
echo "$linked" | sed 's/^/  /'
echo "$CONFIG lists:"
echo "$listed" | sed 's/^/  /'
exit 1
