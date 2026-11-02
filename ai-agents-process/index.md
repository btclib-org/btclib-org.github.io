---
layout: default
title: ai-agents-process
description: The btclib-org process for coding agents
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# ai-agents-process

ai-agents-process is the process the btclib-org maintainers follow with
the coding agents [Claude Code](https://claude.com/claude-code) and
[Codex](https://developers.openai.com/codex): the `/btclib-iss` and
`/btclib-pr` skills, from an issue or a pull request to `main`, the
`/btclib-table` skill, which only reads, the writer and reviewer agents, and
the gate lock every worker takes before its heavy gates.

## Install

It is not a package. Export the path its clone will have as `PROCESS`,
clone it there, and link its files where each agent reads them:

```shell
export PROCESS=~/Git/ai-agents-process
git clone https://github.com/btclib-org/ai-agents-process "${PROCESS:?}"
```

The README has the line that keeps `PROCESS` set in every later shell, the
`ln -s` lines, the hook and the prerequisites. Then:

```text
/btclib-iss <issue URLs or numbers>
/btclib-pr [pull request URLs or numbers]
/btclib-table
```

In Codex each starts with `$` instead of `/`.

## Links

- [Source](https://github.com/btclib-org/ai-agents-process)
- [Changelog](https://github.com/btclib-org/ai-agents-process/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/ai-agents-process/issues)
- [Contributing](https://github.com/btclib-org/ai-agents-process/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/ai-agents-process/security/policy)
- [Report a vulnerability, privately](https://github.com/btclib-org/ai-agents-process/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/ai-agents-process/blob/main/LICENSE)
