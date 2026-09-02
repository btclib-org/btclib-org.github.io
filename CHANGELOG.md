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
- **`.github/workflows/links.yml`, the `links` sentinel section 10 gives
  every repository** (closes #1). What this tree serves is `index.md`,
  whose body is `btclib-org/.github`'s `profile/README.md` byte for byte
  and whose link destinations all point outside this repository; nothing
  here asked whether they still resolve, `local-link-prefix` being about
  how a destination is spelled and `website.yml` fetching nothing it
  builds a link to. Weekly and on demand, never a merge gate: a link rots
  with nobody touching the tree, so a red run is a notification rather
  than something to re-run.
- **The badge row reads section 10's record correctly, and carries
  `?branch=main`** (issue #1). That record names this tree in two
  sentinel entries, `links` and `homepage`, where the row's own comment
  had said it is in none; the row now carries the `links` badge and says
  the missing `homepage` one is issue #8. Both badges are qualified,
  which section 2 asks of gates and sentinels alike: unqualified, a
  workflow with no run on `main` renders some other branch's, a deleted
  branch's included, with nothing in the render to say so.

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

- **The tree stops saying it carries no schedule** (issue #1).
  `36 4 * * 6` is section 10's calendar read — Saturday 04 for `links`,
  minute 36 for this repository — and not a time chosen here, so
  `CLAUDE.md`'s rule is now which section names a `cron:` rather than
  that none may exist. `REPOSITORY.md` records that both rows
  exist and that `links.yml` is not a required check and must not become
  one; `homepage.yml`'s header stops waiting on the calendar, which has
  named its instant too, and names the issue where taking it is weighed.

### The badge row is the whole of what section 2 derives for this tree

- Section 10's record names this tree in two sentinel entries and the row
  carried one of them (closes #8); it now carries both, in the order that
  section's calendar gives them. `homepage.yml` runs on every push to
  `main`, so the badge answers with a measurement rather than `no
  status`.
- The row carries pre-commit.ci's badge (closes #10), section 2 giving
  one to a tree on the service and putting it first among the gates.
  `results.pre-commit.ci/badge/…/main.svg` answers `passed` here and
  `unknown` for a tree that is not on it, which is the control. It takes
  no `?branch=main`: section 2 puts the service's own badge outside that
  rule, its branch being in its path.
- The comment above the row is corrected with them. It had enumerated the
  properties section 2 reads and left pre-commit.ci out of the list,
  which is the omission that let the row look complete while it was short
  two badges.

### `CLAUDE.md` says where the next changelog entry goes

- The open section carries `### Added` and `### Changed`, and section 9
  of the standard now gives a `###` to one entry and never to a theme
  several entries share (issue btclib-org/.github#586). They are landed
  text and stay; what the file says is that a new entry takes a heading
  of its own after them, with nothing above it moving. That is the
  section's own rule for a file already carrying such headings, and it
  presupposes them rather than defining them — so nobody here has to
  rule on whether a `Keep a Changelog` bucket is a theme, which would be
  a change to the standard made outside its own README.
- Beside it, the command that reads whether that held, pointing at
  section 9's *A rebase's result is read* for the rule and adding an exit
  code to it: whether the base is still a byte-for-byte prefix of the
  file. `merge=union` never conflicts and no gate reads the order two
  `###` sections sit in, so a rebase can move a block with nothing going
  red anywhere.

### `https://www.btclib.org/` answers, and the record says so

- The Pages certificate names `www.btclib.org` beside the apex (closes
  #6), and `REPOSITORY.md` records the `.https_certificate.domains` the
  issue named as its readback. `www` is a `CNAME` to
  `btclib-org.github.io` and no longer to the apex, that being the target
  GitHub's documentation asks for; the zone is at the registrar, so the
  change was not this repository's to make and its answer is what the
  file records.
- The certificate answering today is not the one this file recorded when
  the domain was claimed. That entry read it as `btclib-org/btclib`'s,
  carried across rather than issued; the one served now has a `notBefore`
  after the commit that added `CNAME`, and the command whose two answers
  were that entry's evidence has only one of them left — `btclib` has no
  Pages site, so its half exits `1` on a `404`. Nothing above is
  rewritten: what the file carries instead is a pair whose answers can
  both still be read, the served certificate's own `subjectAltName`
  beside the endpoint's `domains` — reached with `-text` and a `grep`,
  `-ext subjectAltName` being an OpenSSL option the LibreSSL macOS ships
  as `openssl` rejects.
- Two further readbacks in that section went stale with `btclib`'s site.
  `{cname}` on the released domain now `404`s where it printed
  `{"cname":null}`, and is dropped for the pointer to `btclib`'s own
  `REPOSITORY.md`, which carries that `404`; the path GitHub served that
  repository's project site under `404`s too, and that is what the file
  records where it recorded an `html_url`. What the first of them
  carried — that `gh api --jq '.cname'` prints an empty line for a JSON
  `null`, so a `# null` beside that spelling quotes the reader — stays as
  the rule the file spells its readbacks by.

### `.gitattributes`'s comment names the driver's sides and one anchor

- **The comment keeps `ours` first and `theirs` second, names which side
  each of a merge and a rebase calls `ours`, and premises the driver on
  an entry arriving at one shared anchor rather than a bullet appended
  to one of a few changelog groups** (issue btclib-org/.github#646).
