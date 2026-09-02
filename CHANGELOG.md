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

### The homepage catches up with the organization page

- `index.md` is re-derived at `btclib-org/.github`'s `1c0d33e`. Two
  commits there moved `profile/README.md` since the pin this file
  carried, `ccc5222` and `a8ac6e1`: the page now carries a row for this
  repository, points its `btclib` link at that library's documentation
  rather than at this domain, spells the organization `btclib.org` and
  the library's language `Python` rather than `Python3`, corrects two
  university names, widens the `.github` row from the repositories above
  it to every repository of the organization, says *test vectors* where
  it said *vectors*, and puts the licence line under a heading of its
  own.
- Nothing above is written here. The body is that file's bytes, which is
  what `homepage.yml`'s verify job re-derives and what its stale job had
  been red about since the text moved — a red stale job being the
  notification that `CONTRIBUTING.md`'s *Changing the homepage* is owed,
  not a gate that broke.
- `_config.yml`'s `title` follows the page to `btclib.org`. The theme
  renders it as the sidebar heading and as the leading half of the
  document title, beside a body whose own first heading the commits
  above renamed — so leaving it would have served a page disagreeing
  with itself. The repository description still spells the organization
  the other way; it is a setting outside the tree rather than a line in
  this diff, and it is issue #18.

### One shellcheck across the tree is a gate rather than a sentence

- `.github/scripts/check-shellcheck-pin.sh` reads the `shellcheck-py`
  hook's `rev` and actionlint's `shellcheck-py==` pin together and exits
  `1` where they name two releases (closes #17). `.pre-commit-config.yaml`
  had stated that invariant in prose since it was written, and nothing
  read it: `autoupdate` moves the rev weekly and nothing moves the pin,
  dependabot having no pre-commit ecosystem, so the pair drifts in one
  direction while every check stays green.
- The comparison is not string equality, and the script says why. A
  `rev` is a git tag and the pin is a PyPI version, and upstream re-cuts
  a tag with a `-N` suffix for a packaging change without moving the
  version that tag declares — `v0.11.0.1-1` and `v0.11.0.1` both declare
  `version = 0.11.0.1`, as `v0.7.0.1-1` and `v0.7.0.1` both declare
  `0.7.0.1`. The tag is normalised for that and the releases compared.
  What the check trades away is a `-N` re-cut that did move the version,
  which would pass; the script carries the network command that settles
  one, since it needs neither that nor a token to answer the drift it is
  for.
- Each half is required to appear before anything is compared, and a
  count of zero fails rather than passes: a pattern that has stopped
  matching answers zero on both sides, and a check that compares nothing
  with nothing is green forever. A quoted `rev`, which the `pinned-rev`
  hook beside this one contemplates, and a commit SHA, which that hook
  allows and which names no release at all, each get an answer of their
  own rather than a comparison against a string that is not a version.
- The sentences that named the derivation script as the tree's only one
  move with it, `.pre-commit-config.yaml` carrying three of them,
  `REPOSITORY.md`'s *No code scanning* and `CONTRIBUTING.md`'s *The
  environment and the gates* one each. The last is below the marker
  `verbatim_test.py` stops at, so the shared half of that file is
  untouched — and the third in the config is the contrast beside
  actionlint, which had named `derive-homepage.sh` as what the other
  hook reads.
- The comment above the hook says the same in prose, a review of the
  revision bump that landed before this having read the two spellings as
  drift — the hook at `v0.11.0.1-1` beside `shellcheck-py==0.11.0.1` —
  and offered either pinning the dependency to the tag string or
  revising the comment. The first was never available: PyPI carries no
  `0.11.0.1-1`, that spelling normalising to `0.11.0.1.post1`, which it
  does not carry either.
- What that re-cut changes upstream is two declarations rather than a
  release: `.pre-commit-hooks.yaml` gains `exclude_types: [zsh]`, and
  `setup.cfg` raises `python_requires` from `>=3.9` to `>=3.10`. The
  first changes nothing here — `identify`, which selects a hook's files,
  tags no file in this tree `zsh`, so the exclusion selects nothing away.
  The second is a floor on the interpreter pre-commit builds the hook
  environment with, recorded here rather than measured against a
  machine.

### CLAUDE.md's worktree removal line stands in a block of its own

- **`git worktree remove --force "$WT"` stands in a block of its own**
  (issue btclib-org/.github#676): the line above it ends in a
  placeholder, and a shell that discards that line as a parse error
  reads the next as a fresh command, so a paste of the block removes
  whatever `$WT` a session that has already been through it still holds.
  Its own block is the one CLAUDE.md's reader pastes deliberately.

### The site's tagline spells the organization the way its page does

- The repository description reads `The btclib.org organization site`
  (closes #18), and `REPOSITORY.md` records what the field now answers.
  That field is not a github.com string alone: `_config.yml` declares no
  `description`, so the theme falls back to `site.github.project_tagline`
  and the site serves it under the heading, in `<title>`, in the
  `description` and `og:description` meta elements and in the JSON-LD —
  so the page had been showing `btclib.org` as its heading and
  `btclib-org` in the line beneath it.
- `1599b9f` is why that is the wrong spelling rather than a preference:
  it corrected the identical sentence in `README.md`, and the field
  carried the copy that commit did not reach. `_config.yml`'s own opening
  line carried a third, which goes with it — and loses the clause naming
  the domain, the name now carrying it.
- Recorded beside the readback: the login is `btclib-org` and has not
  moved, the sentence naming the site rather than the login; and Jekyll
  reads the field at build time, so the served page and the endpoint
  disagree until something pushes.

### The wrapping note in `check-shellcheck-pin.sh` points at section 9

- **The note for whoever edits that header names the rule and where it
  is read** (closes btclib-org/.github#689): section 9 of the standard
  states how a sentence containing the word `shellcheck` may wrap, so
  the note points at it rather than stating it a second time — *One fact
  in one place*. The pointer names no outcome, where the note it
  replaces named only `SC1072` and a red gate: the standard also covers
  the wrap that reads as a valid directive, where the run exits 0 and a
  real finding beside it is suppressed.

### The page's chrome links the projects and credits the supporters

- **The sidebar carries a link to each of the organization's
  repositories, under the profile link, and the footer carries the logos
  of Digital Gold Institute and CheckSig beside the hosting and theme
  credit** (closes #23). The page's body already names both — every
  repository at length, and those two as supporting the work — but that
  body is generated from `btclib-org/.github`, and the chrome around it
  was the theme's own with nothing of the organization in it.
- `jekyll-theme-minimal` offers an include point for `head` and for
  nothing else, so both blocks cost a copy of its whole
  `_layouts/default.html`. A copy of a gem's file is a fact about that
  gem recorded outside it, and `Gemfile`'s `github-pages` pin is a line
  dependabot moves: `.github/scripts/check-theme-copies.sh` strips the
  fenced blocks and requires what is left to be the installed gem's file
  byte for byte, and `website.yml` runs it where bundler has already
  resolved that gem. A theme whose layout has moved is then a red check
  on dependabot's own pull request rather than a page serving the chrome
  of a release nobody runs.
- The same script reads `assets/css/style.scss`, which shadows the gem's
  file of that name outright. This tree's is the gem's own bytes with
  rules appended, so what is required of it is that it open with them —
  a theme release that adds an import to its stylesheet being otherwise
  half a stylesheet served in silence, the site building green either
  way.
- The repositories are `_config.yml`'s `projects`, and the body links
  the same set out of another tree, so the two can drift with nothing
  failing. `.github/scripts/check-projects.sh` reads the `btclib-org`
  addresses out of `index.md` and requires the list to be exactly their
  set — the page rather than the organization's API, so the check needs
  no token and compares the two things a visitor is shown.
- One of that stylesheet's declarations is a repair rather than an
  addition: the theme positions every `ul` inside the header absolutely
  over a band of widths, a rule written for the row of download buttons
  it ships, and in that band the list of projects is what would
  otherwise land in the corner, detached from its own label. `static`
  is declared unconditionally rather than inside a copy of the theme's
  own media query, which would put the only copy of a theme breakpoint
  this tree holds in a file nothing compares against the theme.
- The logo files are each press kit's own bytes. `_config.yml` carries
  the addresses they were fetched from and the command that says whether
  a copy is still what those addresses serve, no gate here asking that;
  the links go to `dgi.io` and `checksig.com`, which is where the body's
  own sentence about the two already sends a reader.
- `website.yml`'s `paths` filter named the files a Jekyll build reads
  and `_layouts` and `assets` were not among them, so a later change to
  the layout, the stylesheet or a logo would have gone to `main` without
  the workflow that exists to catch a page which stopped rendering ever
  asking. Both are named now, with the script the job runs.
- That job also asserts the two blocks in the built page, among the
  assertions it already makes about `_site`. It is the one thing that
  reports what `check-theme-copies.sh` is unable to: a fenced block
  removed whole takes its fences with it, which leaves the count even
  and the remainder equal to the gem's file.
- `CONTRIBUTING.md`'s *Changing the homepage* says that where the
  organization's set of repositories moved, `_config.yml` moves in the
  same commit — the `projects` hook refusing one where the sidebar and
  the body disagree, and printing both lists in the refusal. Every place
  that called what happens here after a correction upstream *one
  command* is wrong for the same reason and moves with it: `CLAUDE.md`,
  `links.yml`, and `homepage.yml` both in the comment above its stale
  job and in that job's own `::error::`, which is the line a maintainer
  reads at the moment the instruction is about to be followed.
  `links.yml` also stops claiming that the root markdown is the whole of
  what the site invites a visitor to follow. What the layout brings into
  the tree is the shiv it loads, the credit it prints and the profile
  address it builds out of `site.github`, and no file that gate reads
  holds any of the three; whether they belong in it is issue #25.
  `REVIEWING.md`'s own last section gains the question the copies raise,
  beside the one it already asks about `index.md` being edited by
  hand.
- `.typos.toml` gains `repository_nwo`, which the theme's layout renders
  on a project page. The hook runs with `--write-changes`, and on the
  first run over the copy it rewrote those three letters to `now` — the
  rewrite that file already records for `PAGES_REPO_NWO`, arriving a
  second time in a place where `check-theme-copies.sh` would have
  reported it as the theme having moved, sending a reader into a gem to
  look for a change a hook here had made.
- `AUTHORS.md` says which files in the tree are somebody else's work,
  which section 14 of the standard asks of a tree that vendors any: the
  two theme files, under `pages-themes/minimal`'s own licence, and the
  two logo files, which are marks belonging to their owners and are here
  to credit them. Its sentence naming what *is* authored here was true
  before this branch and is not after it, so it moves in the same diff.
- `.pre-commit-config.yaml` gains `check-xml`, that file's own rule
  applied: the logo files are the type the tree grew, `identify` tags
  them `xml`, and a check-only hook is what suits bytes fetched from
  somebody else.
- The sentences that listed this site's sources move with them.
  `_config.yml`'s own opening named `index.md`, `_config.yml`, `Gemfile`
  and `CNAME`; `README.md`'s *The rest of the tree* named the last three
  of those, its homepage section covering the first; `CLAUDE.md`'s
  *Architecture* named `index.md`, `_config.yml` and `Gemfile`.
  `CLAUDE.md` also gains the fact the copies introduce and a session
  would otherwise learn from a red check: the bytes that are the gem's
  are the layout outside a fence and the stylesheet up to and including
  its import, and not everything above the appended rules — this tree's
  own comment sits between the two and is ordinary text to edit.

### The link check reads the page a visitor is served

- **`links.yml` gives lychee the deployed site as well as the root
  markdown** (closes #25). The page carries destinations no `*.md`
  holds: the profile address `_layouts/default.html` builds out of
  `site.github`, and the theme's own credit. Measured, before and after
  — `lychee --dump` over the markdown alone prints neither, and with the
  site among the inputs it prints both.
- The page rather than the layout, though the layout is now in this
  tree. lychee reads it as html and turns every Liquid expression
  standing in an `href` into a `file://` path under `_layouts`, so that
  input would report a run's worth of dead links that are not links.
  Fetching the rendered page yields absolute destinations and asks
  jekyll of nothing here.
- It is the *deployed* site, so the run answers about `main` and not
  about a branch. That is what a weekly sentinel is for, and it is the
  arrangement this workflow already rested on: the root markdown links
  `btclib.org`, so every run has fetched the deployed site — which is
  also how a `CNAME` that stopped reaching `_site` would surface. The
  header's own sentence about that had named `index.md`, which spells
  the address as text and links it nowhere, and moves with this.
- The credit is a destination this tree cannot edit, which the comment
  now says. It sits outside every fence in `_layouts/default.html`,
  where `check-theme-copies.sh` compares the bytes with the gem's, so a
  red run naming it is answered by an `--exclude` or by a theme release
  rather than by correcting the link — and not by fencing that line
  either: a fence marks what this tree *adds*, and the script removes
  what it marks before comparing, so fencing a line the gem still holds
  fails the comparison instead of excusing it.
- What the page offers and the run does not fetch goes unfetched for two
  different reasons. `scale.fix.js` is excluded by verbatim handling — lychee
  treats a `script` element as verbatim, and `--include-verbatim` prints
  it — and that flag is not passed because of the *markdown*, which it
  would send lychee through fence-first, after every address quoted in a
  command. The theme's IE shiv is excluded by its conditional comment,
  which no flag reverses: that same flag does not print it either.
- `_config.yml`'s note on the supporters' addresses loses the clause
  saying that choosing the body's address is what keeps them within
  reach of `links.yml`. This change is what makes that false: the footer
  renders each `supporters` entry as an anchor, and the page is now an
  input.

### The chrome names the organization and says who supports it

- **The tagline reads `The btclib organization website`, and the
  footer's credit is preceded by a sentence naming the two institutions
  that support the work, each linked** (closes #28). The tagline is the
  repository description, a setting outside the tree, so
  `REPOSITORY.md` moves with it and `README.md`'s own heading, which is
  the same sentence, moves with it too.
- The sentence is generated from `_config.yml`'s `supporters`, the same
  list the logos above it come from, so an institution added there is
  named in both places or in neither. Each entry's `name` is the logo's
  alt text; `short` is how the sentence reads it aloud, and the layout
  falls back to `name` where an entry declares none, which is why only
  the first carries one.
- The credit itself is untouched. It is the theme's own line, and
  `check-theme-copies.sh` requires every byte outside a fenced block to
  be the installed gem's, so the sentence is a block of its own placed
  before it. That leaves two `p` elements where a reader is to see one
  line, which `assets/css/style.scss` closes by rendering both inline —
  the space between them being the newline in the source.
- Both fenced blocks now ask whether their list is empty as well as
  whether it is there. Liquid reads an empty array as true, so
  `supporters: []` rendered the sentence with nobody in it, and
  `projects: []` had been giving the sidebar a label above an empty
  list. Measured on four shapes of the key: absent, empty, one entry and
  two.
- `website.yml` asserts the new element in the built page beside the
  other two. The sentence went inside the fence the logos already had,
  and the script strips a fenced block before comparing what is left
  with the gem's file, so it never looks inside one: those three greps
  are the only assertion anywhere about what a fence holds.
