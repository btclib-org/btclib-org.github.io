---
layout: default
title: portanode
description: Portable cross-platform Bitcoin full node
---
<!-- markdownlint-configure-file {"MD025": {"front_matter_title": ""}} -->

# portanode

PortaNode bundles scripts, binaries and data for running Bitcoin Core, and
Electrum, from a portable external disk shared between macOS, Windows and Linux.

It works best on an NVMe drive in a portable USB 3 or Thunderbolt enclosure,
formatted for the operating systems it has to run under. The README's *Choosing
a filesystem* says which.

## Install

It is not a package. Take the folder onto the disk it will run from:

```shell
git clone https://github.com/btclib-org/portanode.git
```

or unzip the ZIP of `main` that the repository page offers. The README has the
prerequisites, among them at least 700GB free for a full mainnet sync, and the
quick start.

## Links

- [Source](https://github.com/btclib-org/portanode)
- [Releases](https://github.com/btclib-org/portanode/releases)
- [Release notes](https://github.com/btclib-org/portanode/blob/main/RELEASE_NOTES.md)
- [Changelog](https://github.com/btclib-org/portanode/blob/main/CHANGELOG.md)
- [Issues](https://github.com/btclib-org/portanode/issues)
- [Contributing](https://github.com/btclib-org/portanode/blob/main/CONTRIBUTING.md)
- [Security policy](https://github.com/btclib-org/portanode/security/policy)
- [Report a vulnerability, privately](https://github.com/btclib-org/portanode/security/advisories/new)
- License: MIT, in [LICENSE](https://github.com/btclib-org/portanode/blob/main/LICENSE)
