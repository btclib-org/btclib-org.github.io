---
layout: default
title: bip32-descriptors
description: BIP32 keys, output script descriptors and miniscript, built on btclib
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# bip32-descriptors

bip32-descriptors implements BIP32 hierarchical deterministic keys, BIP380
output script descriptors, BIP388 wallet policies and BIP379 miniscript, in
typed Python.

It is built on btclib, the protocol package, and ecc, the curve package.
Signing, partially signed transactions and wallets are not here: btclib-wallet
is the library above this one.

## Install

```shell
python -m pip install --upgrade bip32-descriptors
```

The `secp256k1` extra adds the libsecp256k1 bindings. Without them the Python
arithmetic answers instead.

```shell
python -m pip install --upgrade "bip32-descriptors[secp256k1]"
```

## Links

- [Documentation](https://bip32-descriptors.readthedocs.io)
- [Source](https://github.com/btclib-org/bip32-descriptors)
- [Releases](https://github.com/btclib-org/bip32-descriptors/releases)
- [Release notes](https://github.com/btclib-org/bip32-descriptors/blob/main/RELEASE_NOTES.md)
- [Changelog](https://github.com/btclib-org/bip32-descriptors/blob/main/CHANGELOG.md)
- [The package on PyPI](https://pypi.org/project/bip32-descriptors/)
- [Issues](https://github.com/btclib-org/bip32-descriptors/issues)
- [Contributing](https://github.com/btclib-org/bip32-descriptors/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/bip32-descriptors/blob/main/SECURITY.md)
- [Report a vulnerability, privately](https://github.com/btclib-org/bip32-descriptors/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/bip32-descriptors/blob/main/LICENSE)
