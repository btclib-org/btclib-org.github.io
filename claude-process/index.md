---
layout: default
title: claude-process
description: The btclib-org Claude Code process
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# claude-process

claude-process is the process the btclib-org maintainers follow with
[Claude Code](https://claude.com/claude-code): the `/btclib-org` command, from an
issue or a pull request to `main`, the writer and reviewer agents, and the gate
lock every worker takes before its heavy gates.

## Install

It is not a package. Clone it and link its files into `~/.claude/`:

```shell
git clone https://github.com/btclib-org/claude-process ~/Git/claude-process
```

The README has the `ln -s` lines and the prerequisites: Claude Code, `gh`, `uv`
and signed commits. Then:

```text
/btclib-org <issue or pull request number>
```

## Links

- [Source](https://github.com/btclib-org/claude-process)
- [Changelog](https://github.com/btclib-org/claude-process/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/claude-process/issues)
- [Contributing](https://github.com/btclib-org/claude-process/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/claude-process/security/policy)
- [Report a vulnerability, privately](https://github.com/btclib-org/claude-process/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/claude-process/blob/main/LICENSE)
