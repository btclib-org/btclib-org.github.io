---
layout: default
title: btclib
description: A library for 'bitcoin cryptography'
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# btclib

btclib is a type annotated Python library for teaching, learning and using
bitcoin, focused on elliptic curve cryptography and bitcoin's blockchain.

It started as a teaching tool for Ferdinando Ametrano's *Bitcoin and Blockchain
Technology* course and is used in production today. It is still marked beta,
because it is refactored whenever that makes it clearer.

## Install

```shell
python -m pip install --upgrade btclib
```

The recommended install adds the libsecp256k1 bindings, `pip install
"btclib[secp256k1]"`. Without them btclib still answers, on Python arithmetic
that is slower and not constant-time. Its security policy says more.

## Links

- [Documentation](https://btclib.readthedocs.io)
- [Source](https://github.com/btclib-org/btclib)
- [Releases](https://github.com/btclib-org/btclib/releases)
- [Release notes](https://github.com/btclib-org/btclib/blob/main/RELEASE_NOTES.md)
- [Changelog](https://github.com/btclib-org/btclib/blob/main/CHANGELOG.md)
- [The package on PyPI](https://pypi.org/project/btclib/)
- [Issues](https://github.com/btclib-org/btclib/issues)
- [Contributing](https://github.com/btclib-org/btclib/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/btclib/blob/main/SECURITY.md)
- [Report a vulnerability, privately](https://github.com/btclib-org/btclib/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/btclib/blob/main/LICENSE)
