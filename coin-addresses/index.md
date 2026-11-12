---
layout: default
title: coin-addresses
description: Cryptocurrency addresses from public keys, and their validation
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# coin-addresses

coin-addresses takes a public key to the address a coin derives from it, and
validates an address, in typed Python. Nothing above that is here: no
transactions and no signing.

It is built on ecc, the curve package, and not on btclib. Ethereum comes first:
`coin_addresses.evm` derives and validates the addresses of Ethereum and of the
EVM chains, with their EIP-55 checksum. The first release is to cover the coins
on secp256k1: the bitcoin clones, the EVM chains, Tron, Cosmos and XRP. A second
stage adds the ed25519 coins that derive by SLIP-0010, and a third Cardano,
Polkadot and Monero, as the organization's
[roadmap](https://github.com/btclib-org/.github/blob/main/ROADMAP.md) says.

## Install

Nothing is released yet: no version is on PyPI or among the GitHub releases.
The source is read on GitHub or from a clone.

```shell
git clone https://github.com/btclib-org/coin-addresses.git
```

## Links

- [Documentation](https://coin-addresses.readthedocs.io)
- [Source](https://github.com/btclib-org/coin-addresses)
- [Release notes](https://github.com/btclib-org/coin-addresses/blob/main/RELEASE_NOTES.md)
- [Changelog](https://github.com/btclib-org/coin-addresses/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/coin-addresses/issues)
- [Contributing](https://github.com/btclib-org/coin-addresses/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/coin-addresses/blob/main/SECURITY.md)
- [Report a vulnerability, privately](https://github.com/btclib-org/coin-addresses/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/coin-addresses/blob/main/LICENSE)
