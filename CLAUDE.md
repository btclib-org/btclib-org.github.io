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

`index.md` is the homepage and the product; `_config.yml`, `Gemfile`,
`_layouts/` and `assets/` are what Jekyll and GitHub Pages read to serve
it. Everything else in the tree is process around those.

## The primary checkout is the maintainer's

**Never work in it.** No edit, no `git add`, no commit, no branch switch,
no rebase, no `git stash`. It is a local reference only, and it stays on
`main`.

Reading it is fine, but `git fetch` moves `refs/remotes/origin/main` and
leaves the work tree where it was, so a `grep` or a `Read` against the
checkout answers for whenever it was last brought forward, not for now.
The read that cannot go stale is `git show origin/main:<path>`.

**Every session works in a worktree**, its own, from the first edit,
named `wt-<tracker>-<issue>-<repo>-<role>`: the repository whose issue
tracker holds the issue, the issue, the repository this worktree is for,
and what is being done in it. An issue number is unique only within one
tracker, and one issue is often owed by several repositories, which is
what each part answers.

```shell
WT=<scratchpad>/wt-<tracker>-<issue>-<repo>-<role>
git worktree add "$WT" origin/main -b <branch>
cd "$WT"
# edit, gate and commit here, then
git push origin HEAD:refs/heads/<branch>
```

`-b <branch>` sits after the path and the commit-ish so that the
placeholder ends the command, which is section 9 of the standard's rule.
With the placeholder ahead of `"$WT"` the `>` closing it takes that path
as its target, and a path with no directory at it is a file the paste
creates.

Removing the worktree is part of finishing, and it stands in a block of
its own: the block above ends in a placeholder, and a shell that
discards that line as a parse error reads the next as a fresh command —
which, in one block, is this line against whatever `$WT` already held.

```shell
git worktree remove --force "$WT"
```

**Never `git stash` in a worktree either: `refs/stash` is shared.** A
worktree isolates files, not refs. Commit to your own branch instead.

**Do not rewrite `refs/heads/main`, or advance it with work that is not
yours.**

## Non-obvious facts that will otherwise waste a session

- **`index.md` is generated, and editing it is the mistake this tree is
  shaped to catch.** Its body is `btclib-org/.github`'s
  `profile/README.md` at the commit its own front matter records, byte
  for byte. A correction to what the site *says* is a pull request
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
- **The site build is not part of the lint gate and cannot be run with
  uv.** jekyll wants a ruby and the `github-pages` gem, both pinned to
  what GitHub Pages itself runs; `website.yml` is where that build
  happens, and `bundle exec jekyll build` is the local equivalent for a
  machine that has that ruby. A session on a machine that does not has no
  way to answer whether the site renders, and says so rather than
  reasoning about it.
- **A `cron:` here is section 10's to name, never this tree's to
  choose.** That section of the standard is a calendar of two tables —
  one giving a workflow its day and hour, the other giving a repository
  its minute — and `tests/grid_test.py` in `btclib-org/.github` fails on
  a schedule no row names and on a scheduling repository with no minute.
  `links.yml` carries the only one so far, `36 4 * * 6`, which is that
  calendar read and not a time anybody picked here. What still has no
  `cron:` is `homepage.yml`, and no longer for want of a row — the
  calendar names its instant too, and btclib-org/.github#558 is where
  taking it is weighed. A schedule for anything else needs its row in
  that tree first, which is the order that section states.
- **`CNAME` is the domain claim, and Pages reads it out of the *built*
  site.** So `btclib.org` is released by anything that keeps that file
  out of `_site` — a `_config.yml` exclude entry, a rename, a deletion —
  on the next build, with no error anywhere; `website.yml` asserts the
  built copy for that reason. A domain belongs to one repository at a
  time, and `btclib-org/btclib` released this one for this tree to claim
  it: `REPOSITORY.md`'s *Pages, which is btclib.org* has the state and
  btclib-org/.github#530 the sequence.
- **`_layouts/default.html` and `assets/css/style.scss` each carry a
  gem's file inside them, and those bytes are not this tree's to
  edit** — the layout everywhere outside its fences, and the stylesheet
  up to and including its import, which is the whole of the gem's
  stylesheet and nothing after it. The first is
  `jekyll-theme-minimal`'s own layout with fenced blocks added, the
  second its own stylesheet with rules appended, and
  `.github/scripts/check-theme-copies.sh` — which `website.yml` runs —
  strips the fenced blocks and requires the remainder to be the gem's
  file, and requires the stylesheet to open with the gem's. So a change
  made outside a fence, or to the stylesheet up to and including its
  import, is a red check whatever it improves; everything below that
  import, this tree's own comment there included, is ordinary text to
  edit. Where the theme is what moved, take its new file and carry this
  tree's parts across, finding them by grepping the copy being replaced
  for the fence marker rather than by remembering how many there were:
  the script's count asks for at least one begin fence and for the ends
  to match it, which a block dropped whole satisfies as long as another
  remains.
- **A finding about the text the site serves is filed in
  `btclib-org/.github`**, that being the tree the text lives in. This
  repository's own tracker is for the site's configuration, the
  derivation and the workflows.

## Conventions to match

Section 9 of the standard is the prose style and governs this file too.
`CONTRIBUTING.md`'s *Pull requests* has what a title does with the issue
it closes, and section 9's changelog bullets what an entry cites.

**`CHANGELOG.md`'s `### Added` and `### Changed` are landed text, not the
shape to copy.** Section 9 gives a `###` to one entry and never to a
theme several entries share, so a new entry takes a heading of its own at
the end of the open section — after those two, with nothing above it
moving, which is that section's own rule for a file that already carries
them. The two stay: *Nothing already written is rewritten*, and a branch
that reshapes them edits the record rather than adding to it.

That the entry landed where it belongs is read rather than assumed, and
section 9's *A rebase's result is read* is where that rule and its
`git diff origin/main..HEAD -- CHANGELOG.md` live. What the command below
adds is an exit code: the same question asked so that a script, or a
session with a hundred lines of diff in front of it, gets an answer
rather than something to look at.

```shell
n=$(git show origin/main:CHANGELOG.md | wc -c)
head -c "$n" CHANGELOG.md | cmp - <(git show origin/main:CHANGELOG.md)
```

Exit 0 says nothing above the new block moved. Read it *after* the
rebase and against the base you rebased onto: run before one, on a branch
whose `origin/main` has since gained an entry, it exits 1 with nothing
wrong with the branch at all. And prove it can fail before believing a
zero — rename one of the two headings in a copy and it exits 1, naming
the line.

## Verifying

Run the command as documented before claiming it works, and read its exit
code rather than its filtered output. Every claim in this file was
checked against the tree, and the tree changes.
