# Repository instructions

Follow [CONTRIBUTING.md](./CONTRIBUTING.md) for issues, pull requests,
local gates, and worktree setup and cleanup. Use
[REVIEWING.md](./REVIEWING.md) for reviews and read
[REPOSITORY.md](./REPOSITORY.md) before changing workflows, Pages settings,
or repository settings.

Work in a worktree of your own, never in the primary checkout: it is the
maintainer's. Follow CONTRIBUTING.md for setup and cleanup.

Choose the least capable model that can reliably complete the task: use a fast
model for straightforward execution, a reasoning-focused model for multi-step
work, and the most capable available model for difficult or ambiguous problems.
Increase capability if progress stalls.

This repository serves <https://btclib.org/>. `index.md` is derived from
`btclib-org/.github`'s `profile/README.md`; follow CONTRIBUTING.md's
"Changing the homepage" before updating it. `_config.yml`, `Gemfile`,
`_layouts/`, and `assets/` control the Jekyll site.

## Code Review Rules

Review against [REVIEWING.md](./REVIEWING.md). Its *The verdict* says
which review opens with a verdict line and what every other review
posts.

The heading is the one Codex's GitHub review asks for
([Customize what Codex reviews](https://learn.chatgpt.com/docs/third-party/github#customize-what-codex-reviews)).
