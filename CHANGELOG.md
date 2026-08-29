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
