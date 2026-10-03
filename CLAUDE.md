# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

This repository is the site served at <https://btclib.org/> and nothing
else. `README.md` says what the tree holds; `CONTRIBUTING.md` is
how to work here, the commands and the gates being its last section;
`REPOSITORY.md` is the settings that live outside the tree — read it
before changing a workflow, a branch rule or a setting. `REVIEWING.md` is
the standard a review is written against, and `.claude/commands/review.md`
is that file as a command.

The organization's standard is
[btclib-org/.github](https://github.com/btclib-org/.github)'s
`README.md`, and this repository is tier 3 of it: sections 9, 11 and 14,
and the rows of the root-files table marked for that tier.

## Architecture

`index.md` is the homepage and the product, and so is each project's page,
the `index.md` of the directory named for it in `_config.yml`'s `projects`,
or of the one `project_paths` gives it;
`_config.yml`, `Gemfile`, `_layouts/` and `assets/` are what Jekyll and
GitHub Pages read to serve them. Everything else in the tree is process
around those.

## The primary checkout is the maintainer's

Never work in it: no edit, no `git add`, no commit, no branch switch, no
rebase, no `git stash` — the hooks fix files in place. The one write
allowed there brings it forward, and only while it is on `main` and
`git status --porcelain` prints nothing; where it is not, stop:

```shell
checkout=<checkout>
```

```shell
git -C "${checkout:?}" pull --ff-only
```

Read it only after that, once this prints one sha twice:

```shell
git -C "${checkout:?}" rev-parse HEAD origin/main
```

A measurement that has to hold at a named revision reads
`git -C "${checkout:?}" show <sha>:<path>` instead.

Every session works in a worktree of its own, from its first edit, named
`wt-<tracker>-<issue>-<repo>-<role>` — `wt-github-255-btclib-writer` for
issue 255 of `btclib-org/.github`'s tracker, worked in `btclib` by a
writer. The environment is created there, with the command `CONTRIBUTING.md`
names under *The environment and the gates*. Every path is written out in
full, `<scratchpad>` being the session's scratch directory:

```shell
git worktree add \
  <scratchpad>/wt-<tracker>-<issue>-<repo>-<role> origin/main -b <branch>
```

Removing it is part of finishing:

```shell
git worktree remove --force <scratchpad>/wt-<tracker>-<issue>-<repo>-<role>
```

`refs/stash` and the local `main` are shared by every worktree: never
`git stash`, and move `main` only by the `git pull --ff-only` above.

## Non-obvious facts that will otherwise waste a session

- **`index.md` is generated, and editing it is the mistake this tree is
  shaped to catch.** Its body is `btclib-org/.github`'s
  `profile/README.md` at the commit its own front matter records, byte
  for byte, and an SVG at the root is an image that page shows, derived
  with it. A correction to what the homepage *says* is a pull request
  against that repository; what happens here afterwards is
  `CONTRIBUTING.md`'s *Changing the homepage*, which is the derivation
  and, where the organization's set of repositories moved, `_config.yml`
  moving with it. `homepage.yml` refuses a pull request whose `index.md`
  is not what its pin derives to, so a hand edit is a red check rather
  than a page that quietly disagrees with the organization's own.
- **Every file in this directory that `_config.yml` does not exclude is a
  public URL.** The `exclude:` list there *replaces* Jekyll's default
  rather than adding to it, which is why it opens by restoring those
  defaults: dropping them would publish the `Gemfile`. A file added to
  the root with no entry is served at `btclib.org/<name>` whether
  anybody meant it to be or not.
- **A `cron:` here is section 10's to name, never this tree's to
  choose.** That section of the standard is a calendar of two tables —
  one giving a workflow its day and hour, the other giving a repository
  its minute — and `tests/grid_test.py` in `btclib-org/.github` fails on
  a schedule no row names and on a scheduling repository with no minute.
  `links.yml` and `homepage.yml` carry the two `cron:` entries this tree
  has, `36 4 * * 6` and `36 3 * * 6`, both that calendar read and not a
  time anybody picked here. A schedule for anything else needs its row
  in that tree first, which is the order that section states.
- **`CNAME` is the domain claim, and Pages reads it out of the *built*
  site.** So `btclib.org` is released by anything that keeps that file
  out of `_site` — a `_config.yml` exclude entry, a rename, a deletion —
  on the next build, with no error anywhere; `website.yml` asserts the
  built copy for that reason. A domain belongs to one repository at a
  time, and `btclib-org/btclib` released this one for this tree to claim
  it: `REPOSITORY.md`'s *Pages, which is btclib.org* has the state and
  btclib-org/.github#530 the sequence.
- **`_layouts/default.html` outside its fences and `assets/css/style.scss`
  up to and including its import are the gem's bytes**, and
  `.github/scripts/check-theme-copies.sh`, which `website.yml` runs, fails
  on any change there. When the theme moves, take its new files and carry
  this tree's fenced blocks across, found by grepping for the fence
  marker.
- **A finding about the homepage's text is filed in
  `btclib-org/.github`**, that being the tree the text lives in. This
  repository's own tracker is for the site's configuration, the
  derivation, the workflows and the text of the project pages.

## Conventions to match

Section 9 of the standard is the prose style and governs this file too.
`CONTRIBUTING.md`'s *Pull requests* has what a title does with the issue
it closes, and section 9's changelog bullets what an entry cites.

**`CHANGELOG.md`'s `### Added` and `### Changed` are landed themes, not
the shape to copy:** a new entry takes its own `###` at the end of the
open section (section 9). After a rebase onto `origin/main`, this exits 0
when nothing above the new block moved:

```shell
worktree=<worktree>
```

```shell
: "${worktree:?}" &&
  head -c "$(git -C "$worktree" show origin/main:CHANGELOG.md | wc -c)" \
    "$worktree/CHANGELOG.md" |
  cmp - <(git -C "$worktree" show origin/main:CHANGELOG.md)
```

## Verifying

Run the command as documented before claiming it works, and read its exit
code rather than its filtered output. Every claim in this file was
checked against the tree, and the tree changes.
