# Changelog

Every user-visible change to this repository, by group. A user here is a
visitor to <https://btclib.org/> and whoever maintains the tree that
serves it.

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
- **The site is served at `btclib.org`** (issue btclib-org/.github#530):
  `CNAME` claims the organization's domain, which `btclib-org/btclib`
  released for this tree to hold. Pages reads that file out of the
  *built* site on each build, so an `exclude:` entry, a rename or a
  deletion hands the domain back with a green build and no log anywhere
  — `website.yml` asserts the built copy for that reason, and
  `REPOSITORY.md` records what the endpoint answers.
- **`REPOSITORY.md` records the certificate, and the readback of a
  released domain prints what the command prints** (issue
  btclib-org/.github#530). `https_enforced` is back in the Pages
  selection with the answer it gives: `true`, and already `true` on the
  first read after the claim, GitHub having carried
  `btclib-org/btclib`'s certificate across rather than issuing one —
  which is why the window the move was budgeted for did not happen.
  `domains` names the apex alone, so `https://www.btclib.org/` fails
  TLS, which predates the move and is issue #6. Recorded beside them:
  the `*.github.io` host redirects here rather than serving a second
  copy, and a project site of the organization is served under this
  domain.

  The readback of `btclib`'s released domain asks for `{cname}` and not
  `.cname`, because `gh api --jq '.cname'` prints an empty line for a
  JSON `null` — so the comment beside it had quoted a word the command
  does not print. No date is written down for the certificate: the
  commands recorded are the two whose *agreement* is the evidence, and a
  certificate's own dates rotate at every renewal.
