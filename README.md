# The btclib-org organization site

<!-- The badge row is section 2 of the organization standard's, and what
a tree carries is read off the tree rather than curated: every repository
carries the lint workflow's badge, and the rest are property-driven --
what an index says about a published package, a suite, a documentation
build, a sentinel section 10's record names this tree in. This repository
publishes nothing, holds no suite and builds no documentation, and that
record names it in two sentinel entries: `links`, which it gives every
repository, and `homepage`, which it gives this tree by name. So the row
below is short of what the record says, and knowingly: it carries the
gate a commit meets and the `links` sentinel after it, and the `homepage`
badge that belongs beside them is issue #8.

Every badge here carries `?branch=main`, which section 2 asks of the
gates' and the sentinels' alike. The row is an audit of `main`, and an
unqualified badge is not always `main`'s: a workflow with no run there
renders some other branch's, a deleted branch's included, with nothing in
the render to say so.

website.yml has no badge for the same reason read the other way: the row
is the standard's list, and adding a workflow to it here would make this
tree's row a curation rather than a reading. -->
[![lint](https://github.com/btclib-org/btclib-org.github.io/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/btclib-org/btclib-org.github.io/actions/workflows/lint.yml)
[![links](https://github.com/btclib-org/btclib-org.github.io/actions/workflows/links.yml/badge.svg?branch=main)](https://github.com/btclib-org/btclib-org.github.io/actions/workflows/links.yml)

The organization site served at [btclib.org](https://btclib.org/), and
nothing else: no package, no suite, no documentation build. GitHub Pages
builds it from this repository's `main` branch at the root, with the
classic Jekyll builder, and `CNAME` is what claims the domain —
`REPOSITORY.md` reads both settings back from the endpoint.

## The homepage is generated

`index.md` is
[btclib-org/.github](https://github.com/btclib-org/.github)'s
`profile/README.md` under Jekyll front matter, and that file is the
organization's page — what github.com/btclib-org renders. One text, one
place it is written, and a second copy of it here is the thing this
arrangement exists to avoid: a transcription is the copy that goes stale.

`.github/scripts/derive-homepage.sh` is what writes it, from the commit
its own front matter records, and the file's body is the source's bytes
with nothing added or rewritten. So the derivation is checkable by
anybody in one command, without reading the script:

```shell
awk 'n>=2 {print} $0=="---" {n++}' index.md | cmp - <(curl -fsSL \
  "https://raw.githubusercontent.com/btclib-org/.github/$(awk \
  '$0=="---"{n++;next} n==1&&$1=="source_commit:"{print $2;exit}' \
  index.md)/profile/README.md")
```

`homepage.yml` asks the same question on every pull request, and asks a
second one on `main`: whether that source still says what this site says.
`CONTRIBUTING.md`'s *Changing the homepage* is what to do about either
answer, and the script's own header has the alternatives that were
weighed against deriving — transcribing the page, a git submodule, a
fetch at build time — and what rejects each.

## The rest of the tree

`_config.yml` is the site's configuration and decides what else in the
root is published at all: the `exclude:` list there **replaces** Jekyll's
default rather than adding to it, so a file added to this directory
without an entry becomes a URL under `btclib.org` whether anybody meant
it to or not.

`CNAME` holds `btclib.org`, and Pages reads it out of the built site on
every build: it is the domain claim as a file rather than only as a
setting, which is why `website.yml` asserts that the site it builds
still carries it.

`Gemfile` names the `github-pages` release GitHub's own builder runs, so
`website.yml` can build the site with the same toolchain and fail out
loud where the builder on GitHub's side fails silently.

The rest is what section 2 of
[the organization's standard](https://github.com/btclib-org/.github)
gives a tier-3 repository: `CONTRIBUTING.md` and `REVIEWING.md`, each the
same file in every repository up to its last section, `REPOSITORY.md` for
the settings that live outside the tree, `CLAUDE.md` for what a session
needs, and `CHANGELOG.md`, `LICENSE`, `COPYRIGHT` and `AUTHORS.md`.
