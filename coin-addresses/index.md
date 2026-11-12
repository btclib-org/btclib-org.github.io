---
layout: default
title: coin-addresses
description: Cryptocurrency addresses from public keys, and their validation
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# coin-addresses

coin-addresses derives the address a coin derives from a public key, and
validates an address handed to it, in typed Python, with nothing above
that: no transaction and no signature.

Nothing is released yet. `coin_addresses.evm` derives and validates the
addresses of Ethereum and of the EVM chains, with their EIP-55
checksum, and each other format arrives in a pull request of its own.
The first release is to cover the coins on secp256k1: the bitcoin
clones, the EVM chains, Tron, Cosmos and XRP.

It builds on ecc for the curve and is to build on base58-bech32 for the
encodings, and not on btclib. It is fully annotated and ships
`py.typed`; its refusals are `coin_addresses.exceptions`'s classes, a
`ValueError` or a `TypeError` under one base, `CoinAddressesException`.

## Use

Run it from a checkout: no release is out yet, and uv is the only tool
that has to be installed.

```shell
git clone https://github.com/btclib-org/coin-addresses.git
cd coin-addresses
uv sync
```

## Links

- [Documentation](https://coin-addresses.readthedocs.io)
- [Source](https://github.com/btclib-org/coin-addresses)
- [Changelog](https://github.com/btclib-org/coin-addresses/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/coin-addresses/issues)
- [Contributing](https://github.com/btclib-org/coin-addresses/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/coin-addresses/blob/main/SECURITY.md)
- [Report a vulnerability, privately](https://github.com/btclib-org/coin-addresses/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/coin-addresses/blob/main/LICENSE)
