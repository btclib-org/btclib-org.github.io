# Changelog

Every user-visible change to this repository, by group. A user here is a
visitor to <https://btclib-org.github.io/> and whoever maintains the tree
that serves it.

## Unreleased

### Added

- **The organization site, served from this repository's `main` at the
  root** (issue btclib-org/.github#530). `index.md` is the homepage and
  is generated from `btclib-org/.github`'s `profile/README.md` rather
  than transcribed from it; `.github/scripts/derive-homepage.sh` writes
  it from the commit the file's own front matter records, and
  `homepage.yml` refuses a copy that is not what that commit derives to.
  No custom domain: `btclib.org` is still held by `btclib-org/btclib`,
  and moving it is a separate change.
- **The root files, the lint gate and the review workflow section 2 of
  the organization standard gives a tier-3 repository** (issue
  btclib-org/.github#530). `CONTRIBUTING.md` and `REVIEWING.md` carry the
  shared half every repository shares and a last section of this tree's
  own; `REPOSITORY.md` records the settings that live outside the tree,
  the Pages configuration among them.

### Changed

- **`.gitattributes` states the union price as section 9 of the
  standard does** (issue btclib-org/.github#423): the driver is a
  checkout's and the forge does not apply it, so a pull request whose
  `CHANGELOG.md` overlaps its base is reported `CONFLICTING` however
  cleanly the pair merges locally, and a rebase on a checkout is what
  clears it.
- **`.markdownlint.jsonc` points at section 14 of the standard for who
  carries it** (issue btclib-org/.github#316), in place of an
  enumeration of trees.
- **`CONTRIBUTING.md`'s shared half is btclib-org/.github's** (issue
  btclib-org/.github#281): the half is replaced whole rather than each
  change applied by hand, a hand-written list of them being what comes
  up short. Among them, *The landing queue* points at `REPOSITORY.md`'s
  *Plan-gated settings* for the ceiling's figure (issue
  btclib-org/.github#412).
