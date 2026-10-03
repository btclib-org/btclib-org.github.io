---
layout: default
title: btclib-ecc
description: Elliptic-curve arithmetic and the schemes built on it, multi-curve, accelerated by libsecp256k1 on secp256k1
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# btclib-ecc

btclib-ecc is elliptic curve arithmetic, and the signature, key-agreement and
commitment schemes built on it, in typed Python.

It works over any curve in short Weierstrass form. It provides ECDSA, BIP340
Schnorr, MuSig2, FROST and Diffie-Hellman among others. It is fully annotated
and ships `py.typed`.

## Install

```shell
python -m pip install --upgrade "btclib-ecc[secp256k1]"
```

The `secp256k1` extra installs the libsecp256k1 bindings, btclib-secp256k1,
which do the secp256k1 arithmetic. Without them every call still answers, on
Python arithmetic that is slower and not constant-time.

## Links

- [Documentation](https://btclib-ecc.readthedocs.io)
- [Source](https://github.com/btclib-org/btclib-ecc)
- [Releases](https://github.com/btclib-org/btclib-ecc/releases)
- [Release notes](https://github.com/btclib-org/btclib-ecc/blob/main/RELEASE_NOTES.md)
- [Changelog](https://github.com/btclib-org/btclib-ecc/blob/main/CHANGELOG.md)
- [The package on PyPI](https://pypi.org/project/btclib-ecc/)
- [Issues](https://github.com/btclib-org/btclib-ecc/issues)
- [Contributing](https://github.com/btclib-org/btclib-ecc/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/btclib-ecc/blob/main/SECURITY.md)
- [Report a vulnerability, privately](https://github.com/btclib-org/btclib-ecc/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/btclib-ecc/blob/main/LICENSE)
