---
layout: default
title: btclib-wallet
description: Bitcoin wallet functionality built on btclib
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# btclib-wallet

btclib-wallet goes from a seed to a signed, broadcast bitcoin transaction, on
top of the btclib library.

btclib is the protocol: the encodings, the scripts, the transactions and the
signature schemes. btclib-wallet is what a wallet does with them. It is fully
annotated and ships `py.typed`.

## Install

```shell
python -m pip install --upgrade btclib-wallet
```

Signing and verifying run where btclib runs them, so its libsecp256k1 bindings,
btclib-secp256k1, are the recommended install beside it.

## Links

- [Documentation](https://btclib-wallet.readthedocs.io)
- [Source](https://github.com/btclib-org/btclib-wallet)
- [Releases](https://github.com/btclib-org/btclib-wallet/releases)
- [Release notes](https://github.com/btclib-org/btclib-wallet/blob/main/RELEASE_NOTES.md)
- [Changelog](https://github.com/btclib-org/btclib-wallet/blob/main/CHANGELOG.md)
- [The package on PyPI](https://pypi.org/project/btclib-wallet/)
- [Issues](https://github.com/btclib-org/btclib-wallet/issues)
- [Contributing](https://github.com/btclib-org/btclib-wallet/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/btclib-wallet/blob/main/SECURITY.md)
- [Report a vulnerability, privately](https://github.com/btclib-org/btclib-wallet/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/btclib-wallet/blob/main/LICENSE)
