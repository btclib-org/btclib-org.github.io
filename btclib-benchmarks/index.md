---
layout: default
title: btclib-benchmarks
description: Benchmarks of btclib and btclib-secp256k1 against their comparands
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# btclib-benchmarks

btclib-benchmarks times btclib and btclib-secp256k1 against the packages they
are usefully compared with: other Python bitcoin libraries, and the other
wrappers of libsecp256k1.

It is a repository of its own because the comparands are third-party packages
that btclib and btclib-secp256k1 never import. An advisory against one then
names the package it is about.

## Use

Nothing is released: the scripts are run from a checkout, with uv as the only
tool to install.

```shell
git clone https://github.com/btclib-org/btclib-benchmarks.git
cd btclib-benchmarks
uv sync --locked
uv run python scripts/03-libraries.py
```

Each script prints the package versions and the arithmetic backend each
comparand ran before any number, and writes its run to `results/`.

## Links

- [Source](https://github.com/btclib-org/btclib-benchmarks)
- [Results](https://github.com/btclib-org/btclib-benchmarks/tree/main/results)
- [Changelog](https://github.com/btclib-org/btclib-benchmarks/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/btclib-benchmarks/issues)
- [Contributing](https://github.com/btclib-org/btclib-benchmarks/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/btclib-benchmarks/security/policy)
- [Report a vulnerability, privately](https://github.com/btclib-org/btclib-benchmarks/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/btclib-benchmarks/blob/main/LICENSE)
