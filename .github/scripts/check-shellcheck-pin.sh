#!/usr/bin/env bash
# One shellcheck reads this tree, or this exits 1.
#
# Two hooks run it. The `shellcheck` hook reads the scripts; `actionlint`
# hands the body of a workflow's `run:` step to whatever shellcheck it
# finds on its PATH, and is given one as an additional dependency so
# that a commit and CI check the same thing. The releases those two
# install have to be one release, which .pre-commit-config.yaml states
# in prose above the hook and nothing else here reads.
#
# Nothing else reading it is the point. pre-commit.ci's weekly
# `autoupdate` moves the `rev:` and nothing moves the `==` pin --
# dependabot has no pre-commit ecosystem -- so the two drift in one
# direction, on a schedule, while every other gate here stays green.
#
# The comparison is not string equality. A `rev:` is a git tag and the
# pin is a PyPI version, and upstream re-cuts a tag with a `-N` suffix
# for a packaging change without moving the version that tag declares:
# v0.11.0.1-1 and v0.11.0.1 both declare `version = 0.11.0.1`, as
# v0.7.0.1-1 and v0.7.0.1 both declare 0.7.0.1. So the tag is normalised
# -- leading `v` off, trailing `-N` off -- and the releases compared.
#
# That normalisation is upstream's convention rather than something read
# here, so a `-N` re-cut that did move the version would pass and should
# not. It is the one case traded away for a check needing neither
# network nor token; what settles such a case is the tag's own
# declaration, and the command for it sits beside the hook in
# .pre-commit-config.yaml rather than a second time here.
#
# Note for whoever edits these comments: a line beginning `# shellcheck`
# is a directive to the very tool this file is about, and an English
# sentence wrapped so that the word lands first on a line is SC1072 and
# a red gate. Wrap around it.

set -euo pipefail

# the paths below are relative to the repository root, so the script
# answers the same wherever it is invoked from
cd "$(dirname "$0")/../.."

CONFIG=.pre-commit-config.yaml
REPOSITORY=https://github.com/shellcheck-py/shellcheck-py

# Each half has to appear exactly once, and that is asserted rather than
# assumed: a pattern that has stopped matching answers zero, and zero
# compared against zero is a check that passes forever without reading
# anything. `grep -c` exits 1 on no match, which `|| true` keeps from
# ending the script before the count is read.
repos=$(grep -c "^  - repo: $REPOSITORY\$" "$CONFIG" || true)
pins=$(grep -c '^ *- shellcheck-py==' "$CONFIG" || true)
if [ "$repos" != 1 ] || [ "$pins" != 1 ]; then
    echo "$CONFIG names $REPOSITORY $repos times and pins" \
         "shellcheck-py== $pins times. This check reads one of each," \
         "so it cannot answer, which is a failure and not a pass." >&2
    exit 1
fi

# `exit` on the next `- repo:` rather than reading on: without it a
# missing `rev:` is answered with the *following* repository's, which is
# a wrong answer where the guard below would have said there is none
rev=$(awk -v want="  - repo: $REPOSITORY" '
    $0 == want { seen = 1; next }
    seen && /^  - repo: / { exit }
    seen && $1 == "rev:" { print $2; exit }
' "$CONFIG")
# `[^[:space:]]` rather than `.`, so that a yaml end-of-line comment
# on the pin line is not read as part of the version -- the `awk`
# above stops at whitespace of its own accord and this matches it
pin=$(sed -n 's/^ *- shellcheck-py==\([^[:space:]]*\).*$/\1/p' "$CONFIG")

if [ -z "$rev" ]; then
    echo "$CONFIG has no rev: under $REPOSITORY. This check reads one," \
         "so it cannot answer, which is a failure and not a pass." >&2
    exit 1
fi

# a rev may be quoted -- the `pinned-rev` hook beside this one
# contemplates it -- and the quotes are not part of the tag
rev=${rev//\"/}
rev=${rev//\'/}

release=${rev#v}
release=${release%-*}

# `pinned-rev` also allows a commit SHA, which names no release and so
# cannot be compared with one. Saying that beats reporting a forty-hex
# "release" that disagrees with the pin for the wrong reason.
case $release in
    *[!0-9.]*)
        echo "the hook is pinned at rev $rev, which names no release" \
             "this can compare with shellcheck-py==$pin. A commit SHA" \
             "is one such rev: move the rev to a tag, or read the" \
             "release off it by hand." >&2
        exit 1
        ;;
esac

if [ "$release" != "$pin" ]; then
    echo "the hook is pinned at rev $rev, which names release" \
         "$release, and actionlint installs shellcheck-py==$pin. Two" \
         "shellchecks then read this tree: one the workflows' inline" \
         "scripts, one the scripts themselves. Move the pin to" \
         "$release, or move the rev back, whichever is the release" \
         "meant." >&2
    exit 1
fi
