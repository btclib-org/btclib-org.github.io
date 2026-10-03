---
layout: default
title: bitcoin-node-tests
description: A conformance suite for any bitcoin node
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# bitcoin-node-tests

bitcoin-node-tests is Bitcoin Core's functional test suite rewritten on btclib,
as a non-regression suite for any node that speaks bitcoin's RPC and p2p. Its
nickname is tf2.

The suite runs today against Bitcoin Core and btclib-node. A node gains an
adapter by subclassing `NodeAdapter` and declaring what it can do. A test passes
on `bitcoind` before its failure on another node counts as a finding.

## Use

The suite is not published to an index. It is run from a checkout, next to the
node tree it tests, with uv as the only tool to install:

```shell
git clone https://github.com/btclib-org/bitcoin-node-tests.git
cd bitcoin-node-tests
uv sync
```

Its `CONTRIBUTING.md` has the commands for the unit suite and for the
integration tests, which start a node and skip without one.

## Links

- [Documentation](https://bitcoin-node-tests.readthedocs.io)
- [Source](https://github.com/btclib-org/bitcoin-node-tests)
- [Changelog](https://github.com/btclib-org/bitcoin-node-tests/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/bitcoin-node-tests/issues)
- [Contributing](https://github.com/btclib-org/bitcoin-node-tests/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/bitcoin-node-tests/security/policy)
- [Report a vulnerability, privately](https://github.com/btclib-org/bitcoin-node-tests/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/bitcoin-node-tests/blob/main/LICENSE)
