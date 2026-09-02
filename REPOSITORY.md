# Repository configuration

What is set on this repository, as the `gh api` call that reads it back
and the answer that call gives today. A setting recorded as prose alone
is one nobody can check; recorded this way, a drift is one command away
from being seen.

Read this before changing a branch rule, a repository setting or a
workflow. `CLAUDE.md` points here rather than carrying it, so that a
session editing the site does not hold it in context.

The rules and the settings live *outside* the tree. What is recorded is
the settings the standard asks about — the ones section 16's checklist
sets on a new repository, and the ones a section of the standard's
`README.md` states a rule for — together with whatever a call quoted for
one of those answers alongside it. That is this file's scope, and *What
this file passes over* at the foot says what falls outside it.

The endpoints these answers come from are the file's own `gh api` lines,
listed rather than restated in a second place that would have to be kept
true:

```shell
grep -o 'repos/btclib-org/btclib-org\.github\.io[a-z/-]*' REPOSITORY.md \
  | sort -u
```

When each answer was read is the commit that wrote it: `git blame
REPOSITORY.md`.

**Where a setting has a reason, the reason is section 11 of
[the organization's standard](https://github.com/btclib-org/.github) and
is not repeated here.** Two copies of an argument are two things to keep
true. What is here instead is the answer this repository gives.

**The repository is public, and that is a prerequisite rather than a
preference.** Rulesets are a paid feature for a private repository on the
free plan, and everything below depends on them; GitHub Pages serves a
site from a private repository only on a paid plan, and Actions is
unmetered only here.

```shell
gh api repos/btclib-org/btclib-org.github.io \
  --jq '{visibility, has_issues}'
# {"has_issues":true,"visibility":"public"}
```

## Pages, which is btclib.org

This is the setting the repository exists for:

```shell
gh api repos/btclib-org/btclib-org.github.io/pages \
  --jq '{build_type, source, cname, https_enforced, public, status}'
# {"build_type":"legacy","cname":"btclib.org","https_enforced":true,
#  "public":true,"source":{"branch":"main","path":"/"},"status":"built"}
```

**`https_enforced` is `true`, and a certificate is what that field is
about.** GitHub issues one for a custom domain on its own, and the one
answering here names both spellings of the domain:

```shell
gh api repos/btclib-org/btclib-org.github.io/pages \
  --jq '.https_certificate | {state, domains}'
# {"domains":["btclib.org","www.btclib.org"],"state":"approved"}
```

No date is written down, a certificate's own dates rotating at every
renewal. What the dates say and the endpoint does not is that its
`notBefore` falls *after* the commit that claimed the domain, so the
certificate was issued for this repository rather than inherited with the
name. `TZ=UTC` is there so that the two answers are in one zone, `x509`
printing GMT and a commit date carrying whatever offset it was written
in. The `DNS:` line beside them is the certificate's `subjectAltName`,
the same pair of names the endpoint gives, read from what is actually
served rather than from the setting:

```shell
echo | openssl s_client -connect btclib.org:443 -servername btclib.org \
  2>/dev/null | openssl x509 -noout -dates -text | grep -e '^not' -e 'DNS:'
TZ=UTC git log -1 --format=%cd --date=iso-local \
  $(git log --diff-filter=A --format=%H -- CNAME)
```

`-text` and a `grep` rather than `-ext subjectAltName`: the `openssl`
macOS ships is a LibreSSL, which has no such option and exits `1` on it.
A command recorded here is for whoever reads the file, not for whichever
build happened to be first on one `PATH`.

`legacy` is GitHub's own Jekyll builder, run on GitHub's side from
`main`'s root. It writes no log a maintainer can read and reports a
failure nowhere, which is why `website.yml` builds the same site with the
ruby and the gem `Gemfile` pins: that workflow's own header has the
argument, and a red check there is the only thing that says the site
stopped rendering.

**`cname` is what this repository claims the organization's domain
with, and `CNAME` in the root is the same value.** Pages reads that file
out of the *built* site on each build, which is what makes the setting a
file here rather than only a setting: `_config.yml` excluding it, or a
deletion, releases `btclib.org` on the next build, and `website.yml`
asserts the built site's copy for that reason. A custom domain belongs
to one repository at a time, so the claim required `btclib-org/btclib`
to release it first; btclib-org/.github#530 is the decision and the
sequence, and `btclib`'s own `REPOSITORY.md` records that it no longer
holds the domain — with the readback, that repository's Pages site being
the thing it no longer has.

**A readback here asks for an object and not a field**: `{cname}` rather
than `.cname`, because `gh api --jq '.cname'` prints an **empty line**
for a JSON `null` and not the word, so a comment reading `# null` beside
that spelling transcribes what the reader expected rather than what the
command answered.

**`btclib-org.github.io` is not a second site**: with a custom domain
set, GitHub redirects the `*.github.io` host to it, so the two names are
one site and not two copies to keep in step.

```shell
curl -sS -o /dev/null -w '%{http_code} %{url_effective}\n' -L \
  https://btclib-org.github.io/
# 200 https://btclib.org/
```

**Nothing of `btclib-org/btclib` is served under a path of this domain**,
that repository having no Pages site. Where it has one, GitHub serves it
under this domain and moves its `html_url` there without being asked,
which is what makes the domain the organization's rather than this
repository's:

```shell
curl -sS -o /dev/null -w '%{http_code}\n' https://btclib.org/btclib/
# 404
```

The apex carries A records to Pages and `www` a `CNAME` to
`btclib-org.github.io`, which is the target GitHub's documentation asks
for and not the apex. Neither record is this repository's to set: the
zone is at the registrar, and what a `CNAME` here decides is which
repository GitHub serves to a request those records already deliver.

```shell
dig +short btclib.org A | sort | tr '\n' ' '
# 185.199.108.153 185.199.109.153 185.199.110.153 185.199.111.153
dig +short www.btclib.org | head -1
# btclib-org.github.io.
curl -sS -o /dev/null -w '%{http_code} %{url_effective}\n' -L \
  https://www.btclib.org/
# 200 https://btclib.org/
```

## Required checks on main

```shell
gh api repos/btclib-org/btclib-org.github.io/branches/main/protection
# {"message":"Branch not protected","status":"404"}
```

**There is no classic branch protection here yet, so no check is
required.** A check context cannot be bound before a workflow has
produced it, which is why `lint.yml` lands before the rule does — the
standard's section 16 puts the required checks in classic protection, and
the call that creates it is the one `btclib-org/.github`'s own
`REPOSITORY.md` carries, with `Lint` as the context and `15368` as the
Actions app.

Until it exists, what holds a pull request is the review the ruleset
below asks for, and what holds every commit reaching `main` is
`main-integrity`.

`website.yml`, `homepage.yml` and `links.yml` are not required checks and
must not become them. The first carries a `paths` filter, and a required
check that produces no run blocks a merge where a skipped one satisfies
it. The second has a job that runs only off a pull request — what it
reports is that another repository moved, which is nothing a merge here
should wait on. The third is both at once: a `paths` filter narrower
still, and a weekly question about the internet that no branch here
introduced. `claude-review.yml` is not one either, and its own header
says why.

## Branch protection and the rulesets

`main` is the repository's default branch and its only one:

```shell
gh api repos/btclib-org/btclib-org.github.io --jq '.default_branch'
# main
```

```shell
gh api repos/btclib-org/btclib-org.github.io/rulesets --jq '.[].id' \
  | xargs -I{} gh api \
    repos/btclib-org/btclib-org.github.io/rulesets/{} \
    --jq '{name, target, enforcement, refs: .conditions.ref_name.include,
           rules: [.rules[].type],
           bypass: [.bypass_actors[]?.bypass_mode]}'
# {"bypass":[],"enforcement":"active","name":"main-integrity",
#  "refs":["refs/heads/main"],
#  "rules":["required_signatures","required_linear_history",
#           "non_fast_forward","deletion"],"target":"branch"}
# {"bypass":["pull_request"],"enforcement":"active",
#  "name":"main-self-merge","refs":["refs/heads/main"],
#  "rules":["pull_request"],"target":"branch"}
```

- `main-integrity` — required signatures, required linear history, no
  force pushes, no deletions — with **no bypass actor at all**, which is
  what makes every one of those true of an administrator too.
- `main-self-merge` — a pull request, an approving review, stale reviews
  dismissed on push, conversations resolved, and `squash` as the only
  merge method it accepts — bypassed by the maintainer in
  **`pull_request` mode**, which excuses its holder while merging a pull
  request and at no other time.

```shell
gh api repos/btclib-org/btclib-org.github.io/rulesets --jq '.[].id' \
  | xargs -I{} gh api \
    repos/btclib-org/btclib-org.github.io/rulesets/{} \
    --jq '.rules[] | select(.type=="pull_request") | .parameters'
# {"allowed_merge_methods":["squash"],
#  "dismiss_stale_reviews_on_push":true,
#  "dismissal_restriction":{"allowed_actors":[],"enabled":false},
#  "require_code_owner_review":false,
#  "require_extra_approval_for_unattributed_changes":true,
#  "require_last_push_approval":false,"required_approving_review_count":1,
#  "required_review_thread_resolution":true,"required_reviewers":[]}
```

**There is no `tag-integrity` ruleset**, and nothing here is tagged:
`CONTRIBUTING.md`'s *A version, and no release* is where that is
measured. The standard asks for the rule over `refs/tags/v*` where a
release tag is cut, and it stands ahead of the first such tag rather than
being created alongside one — so a `v*` pushed here today meets no rule.

## Signed commits

```shell
gh api repos/btclib-org/btclib-org.github.io/commits/main \
  --jq '.commit.verification | {verified, reason}'
# {"reason":"valid","verified":true}
```

`required_signatures` refuses an unsigned commit at the push rather than
noticing it afterwards, and with an empty bypass list it refuses one from
everybody. Any valid signer satisfies it — the maintainer's key, GitHub's
web-flow key on a button-driven merge, a bot's.

What no rule covers is a commit before it is pushed:
`git log -1 --format='%G? %GS'`, an `N` being a defect to fix rather than
to explain.

## Merge methods

```shell
gh api repos/btclib-org/btclib-org.github.io \
  --jq '{squash: .allow_squash_merge, merge: .allow_merge_commit,
         rebase: .allow_rebase_merge, auto: .allow_auto_merge,
         delete_on_merge: .delete_branch_on_merge,
         title: .squash_merge_commit_title,
         message: .squash_merge_commit_message}'
# {"auto":false,"delete_on_merge":true,"merge":false,
#  "message":"COMMIT_MESSAGES","rebase":false,"squash":true,
#  "title":"COMMIT_OR_PR_TITLE"}
```

Squash is the only method GitHub can be asked for. The merge commit is
refused by `main-integrity`'s linear-history rule already, so turning it
off takes away a button that could not have worked; rebase-and-merge
could have, and that is the one this removes.

`COMMIT_OR_PR_TITLE` with `COMMIT_MESSAGES` is the pair the standard asks
for, and which of the two titles lands is its *Merge method* rule.

`allow_auto_merge` is `false`, which is this repository's answer and not
every sibling's: `btclib-org/.github` answers `true`. The standard
mentions auto-merge as the thing that presses the one enabled button once
the checks and the review are in, and asks for no particular value, so
neither answer is a divergence to file.

`delete_branch_on_merge` fires on its own, every landing here being a
merged pull request, so a branch still standing is one that was closed
rather than merged.

## Features

```shell
gh api repos/btclib-org/btclib-org.github.io \
  --jq '{wiki: .has_wiki, projects: .has_projects, issues: .has_issues}'
# {"issues":true,"projects":false,"wiki":false}
```

Issues are on: this repository's own tracker is where a defect in the
site, the derivation or the workflows is filed. A finding about the text
the site serves is not one of those — that text is
`btclib-org/.github`'s, and so is its tracker.

The wiki and the projects board are off. The standard states no rule
about either, so no answer to them is a decision here.

## Topics

```shell
gh api repos/btclib-org/btclib-org.github.io --jq '.topics'
# ["bitcoin","btclib","github-pages","organization-site"]
```

The standard makes a package's `keywords` its topics; there is no package
here and so no keyword list to agree with, which makes the topics a
discoverability question rather than an alignment one. They live here and
nowhere else: a repository restored from a record that passed over them
has no topics.

## The repository description

```shell
gh api repos/btclib-org/btclib-org.github.io \
  --jq '{description, homepage}'
# {"description":"The btclib.org organization site","homepage":null}
```

The description is read by the site as well as by github.com:
`_config.yml` declares no `description`, so the minimal theme falls back
to `site.github.project_tagline`, which is this field. That is why it is
recorded here rather than transcribed into the tree.

**It spells the organization the way the organization page does**, which
is what `README.md`'s own first line spells and what the homepage's first
heading says. The GitHub login is `btclib-org` and has not moved; this
sentence names the site rather than the login, and the site is
`btclib.org`.

**Jekyll reads it at build time, not on request.** So a change to the
field reaches the page on the next build and not before, which is why the
served page and this readback can disagree for as long as nothing pushes:

```shell
gh api repos/btclib-org/btclib-org.github.io --jq .description
curl -sS https://btclib.org/ | grep -o 'name="description" content="[^"]*'
```

`homepage` is null. The standard gives that field to a tree that
releases, as the URL its `pyproject.toml` carries; there is no package
here.

## Token permissions

```shell
gh api repos/btclib-org/btclib-org.github.io/actions/permissions/workflow
# {"default_workflow_permissions":"read",
#  "can_approve_pull_request_reviews":false}
```

`read` is the floor every workflow here starts from. `claude-review.yml`
is the only one whose jobs elevate it — `pull-requests: write` to post a
comment and `id-token: write` for the OIDC token the action mints at
startup. `lint.yml`, `website.yml`, `homepage.yml` and `links.yml` read
the tree and the network and write nothing back.

**What this call cannot say is whether that value is this repository's
own or the organization's**, there being no endpoint that answers.
Nobody has recorded an override here, which is weaker than knowing there
is none — so whoever moves the organization default reads this repository
back afterwards rather than assuming it moved.

```shell
gh api repos/btclib-org/btclib-org.github.io/actions/permissions \
  --jq '{enabled, allowed_actions, sha_pinning_required}'
# {"allowed_actions":"all","enabled":true,"sha_pinning_required":false}
```

`sha_pinning_required` being off means the forge does not enforce what
the standard asks for, so an action pinned to a tag rather than to forty
hex digits would be accepted here. The pins are kept by the convention
instead, and this is what reads them back:

```shell
grep -h 'uses:' .github/workflows/*.yml | grep -v '@[0-9a-f]\{40\} #'
```

answers with nothing.

## Secret scanning and Dependabot

```shell
gh api repos/btclib-org/btclib-org.github.io \
  --jq '.security_and_analysis'
# {"dependabot_security_updates":{"status":"disabled"},
#  "secret_scanning":{"status":"disabled"},
#  "secret_scanning_non_provider_patterns":{"status":"disabled"},
#  "secret_scanning_push_protection":{"status":"disabled"},
#  "secret_scanning_validity_checks":{"status":"disabled"}}
```

**The first three are what the standard asks for and none of them is on
yet.** All three are free on a public repository and off by default, and
turning them on is a settings change rather than a pull request, so this
records the gap rather than closing it. The last two are plan-gated: they
need paid Secret Protection, and the API answers a `PATCH` for them with
200 while leaving them disabled, so that answer records the plan and not
a request. The `detect-secrets` hook in `.pre-commit-config.yaml` is the
compensating control, and it runs before a commit rather than after a
push.

Dependabot alerts answer at their own endpoint, which has no body and
says so with its status — 204 for enabled, 404 for not:

```shell
gh api -i repos/btclib-org/btclib-org.github.io/vulnerability-alerts \
  | head -1
# HTTP/2.0 204 No Content
```

Version bumps are the other half of what Dependabot does here, and they
are a file rather than a setting: `.github/dependabot.yml` declares
`github-actions`, which the standard gives every tree, and `bundler`,
which it gives a tree holding a site `Gemfile`. The pre-commit hook
revisions have no Dependabot ecosystem, and are pre-commit.ci's weekly
autoupdate instead, per the `ci:` block of `.pre-commit-config.yaml`.

## Private vulnerability reporting

```shell
gh api repos/btclib-org/btclib-org.github.io/private-vulnerability-reporting
# {"enabled":true}
```

On, as the standard asks of every tier. The policy the Security tab shows
is `btclib-org/.github`'s, this repository carrying none of its own: the
standard gives `SECURITY.md` to the repositories that publish, and this
one publishes nothing.

## Secrets and environments

```shell
gh api repos/btclib-org/btclib-org.github.io/actions/secrets \
  --jq '[.secrets[].name]'
# []
gh api orgs/btclib-org/actions/secrets/CLAUDE_CODE_OAUTH_TOKEN \
  --jq '.visibility'
gh api orgs/btclib-org/dependabot/secrets/CLAUDE_CODE_OAUTH_TOKEN \
  --jq '.visibility'
# all, twice
```

`claude-review.yml` is the only workflow here that reads a secret, and
this repository holds none of its own. **The two organization commands
are not one asked twice.** A `pull_request` run whose actor is
`dependabot[bot]` is handed the Dependabot secrets rather than the
Actions secrets, so a token registered only in the second resolves to the
empty string on exactly the pull requests `.github/dependabot.yml` opens
— and `claude-review.yml`'s credential step turns that into a red job
saying which secret is missing, rather than a review that silently
reviewed nothing.

```shell
gh api repos/btclib-org/btclib-org.github.io/environments \
  --jq '[.environments[].name]'
# ["github-pages"]
```

`github-pages` is GitHub's own, created when Pages was enabled, and no
workflow here deploys through it: the classic builder does not use a
deployment environment the way the Actions builder does. There is no
`pypi` environment and no trusted publisher, nothing here being
published.

## What is not configured, and why

- **No code scanning**, and GitHub's default setup off with it:
  `gh api repos/btclib-org/btclib-org.github.io/code-scanning/default-setup
  --jq .state` answers `not-configured`. There is no language CodeQL
  analyses in this tree — markdown, yaml, shell — and what reads the
  scripts instead is `shellcheck`, in `.pre-commit-config.yaml`.
- **No schedule for `homepage.yml`.** Section 10 of the standard is a
  calendar of two tables that names an instant for every `cron:` in the
  organization, and this repository now has a row in both — which is what
  `links.yml`'s weekly run reads its own instant off. `homepage.yml`'s
  header says which schedule it would take, and
  btclib-org/.github#558 is where taking it is weighed.
- **No `SECURITY.md`, `RELEASING.md` or `RELEASE_NOTES.md`.** Those are
  the rows section 2 of the standard marks for a repository that
  publishes.

## What this file passes over

The API answers for more than this repository decides, and what is left
out is left out by the scope above rather than by oversight.

**What no call sets.** `gh api repos/btclib-org/btclib-org.github.io`
answers with the repository document, most of which is URLs, counts and
derived state. The fields of it that are settings are the ones the
sections above quote.

**A facility nobody reached for.** Actions variables, self-hosted
runners, webhooks, deploy keys, autolinks and custom property values each
answer empty here, and an empty answer records no decision. Whichever of
them is used one day arrives with the section that uses it.

**A field the standard states no rule about.** `allow_forking`,
`allow_update_branch`, `has_discussions`, `has_downloads` and
`web_commit_signoff_required` are in the repository document and in none
of the `--jq` objects here. Recording a field on no rule grows this file
with GitHub's API rather than with the standard.

The price is that a change to any of those is invisible here, and finding
one means reading the repository document against this file rather than
running a command.
