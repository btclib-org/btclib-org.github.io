<!-- markdownlint-disable-next-line first-line-heading -->
## What this changes

<!-- What the code does now that it did not do before, and why.
     Link the issue it closes, if there is one: "Closes #123". -->

## How it was verified

<!-- The test that covers it, the vector it reproduces, the command you
     ran. New behaviour without a test is the usual reason a pull request
     waits. -->

## Checks

<!-- `lint.yml` is the whole of what a merge here can be gated on.
     `website.yml` builds the site on a pull request that touches one
     of the paths its own `paths` filter names; `homepage.yml` carries
     no such filter and runs on every non-draft pull request here,
     checking that `index.md` still matches its own pin. Both report
     but are not, and must not become, a required check --
     REPOSITORY.md's "Required checks on main" says why. The point of
     running the first two locally is not to wait for CI to say so. -->

- [ ] the lint gate is clean: `uvx pre-commit run --all-files`
- [ ] the site builds: `bundle install && bundle exec jekyll build --strict_front_matter`
- [ ] `CHANGELOG.md` has an entry, if a user would notice the change
- [ ] every commit carries a verified signature

## Anything the reviewer should know

<!-- A decision you are unsure of, an alternative you rejected, a
     specification that is ambiguous, a follow-up you left out on
     purpose. Delete the section if there is none. -->
