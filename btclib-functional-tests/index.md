---
layout: default
title: btclib-functional-tests
description: A conformance suite for any bitcoin node
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# btclib-functional-tests

btclib-functional-tests is Bitcoin Core's functional test suite rewritten on
btclib, as a non-regression suite for any node that speaks bitcoin's RPC and
p2p. Its nickname is tf2.

The suite runs today against Bitcoin Core, btclib-node and btcd. A node gains an
adapter by subclassing `NodeAdapter` and declaring what it can do. A test passes
on `bitcoind` before its failure on another node counts as a finding.

## Use

The suite is not published to an index. It is run from a checkout, next to the
node tree it tests, with uv as the only tool to install:

```shell
git clone https://github.com/btclib-org/btclib-functional-tests.git
cd btclib-functional-tests
uv sync
```

Its `CONTRIBUTING.md` has the commands for the unit suite and for the
integration tests, which start a node and skip without one.

## Links

- [Documentation](https://btclib-functional-tests.readthedocs.io)
- [Source](https://github.com/btclib-org/btclib-functional-tests)
- [Changelog](https://github.com/btclib-org/btclib-functional-tests/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/btclib-functional-tests/issues)
- [Contributing](https://github.com/btclib-org/btclib-functional-tests/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/btclib-functional-tests/security/policy)
- [Report a vulnerability, privately](https://github.com/btclib-org/btclib-functional-tests/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/btclib-functional-tests/blob/main/LICENSE)
