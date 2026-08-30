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

`index.md` is the homepage and the product; `_config.yml` and `Gemfile`
are what Jekyll and GitHub Pages read to serve it. Everything else in the
tree is process around those three.

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
git worktree add -b <branch> "$WT" origin/main
cd "$WT"
# edit, gate and commit here, then
git push origin HEAD:refs/heads/<branch>
git worktree remove --force "$WT"     # removing it is part of finishing
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
  against that repository; what happens here afterwards is one command,
  `CONTRIBUTING.md`'s *Changing the homepage*. `homepage.yml` refuses a
  pull request whose `index.md` is not what its pin derives to, so a hand
  edit is a red check rather than a page that quietly disagrees with the
  organization's own.
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
- **No workflow here may carry a `cron:`.** Section 10 of the standard is
  a calendar of two tables naming an instant for every scheduled run in
  the organization, and `tests/grid_test.py` in `btclib-org/.github`
  fails on a schedule no row names and on a scheduling repository with no
  minute — this repository has neither. The row lands in that tree
  before the `cron:` lands here, which that section states as the order.
- **`CNAME` is the domain claim, and Pages reads it out of the *built*
  site.** So `btclib.org` is released by anything that keeps that file
  out of `_site` — a `_config.yml` exclude entry, a rename, a deletion —
  on the next build, with no error anywhere; `website.yml` asserts the
  built copy for that reason. A domain belongs to one repository at a
  time, and `btclib-org/btclib` released this one for this tree to claim
  it: `REPOSITORY.md`'s *Pages, which is btclib.org* has the state and
  btclib-org/.github#530 the sequence.
- **A finding about the text the site serves is filed in
  `btclib-org/.github`**, that being the tree the text lives in. This
  repository's own tracker is for the site's configuration, the
  derivation and the workflows.

## Conventions to match

Section 9 of the standard is the prose style and governs this file too.
`CONTRIBUTING.md`'s *Pull requests* has what a title does with the issue
it closes, and section 9's changelog bullets what an entry cites.

## Verifying

Run the command as documented before claiming it works, and read its exit
code rather than its filtered output. Every claim in this file was
checked against the tree, and the tree changes.
