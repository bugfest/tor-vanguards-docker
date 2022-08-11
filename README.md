# tor-vanguards-docker 

Tor Vanguards multiarch dockerfile

[![Build multiarch image - latest](https://github.com/bugfest/tor-vanguard-docker/actions/workflows/main.yml/badge.svg)](https://github.com/bugfest/tor-vanguard-docker/actions/workflows/main.yml)
[![Build multiarch image - tag](https://github.com/bugfest/tor-vanguard-docker/actions/workflows/main-tag.yml/badge.svg)](https://github.com/bugfest/tor-vanguard-docker/actions/workflows/main-tag.yml)

Tested architectures:
- amd64
- arm
- arm64

This container uses `pypy` when pre-compiled binaries (https://downloads.python.org/pypy/) are available for the target arch.

| Architecture | Python runtime |
|:------------:|:--------------:|
| `amd64`      | `pypy3`        |
| `arm64` (v8) | `pypy3`        |
| `390x`       | `pypy3`        |
| `arm` (v7)   | `python3`      |
| other        | `python3`      |     

Used by [bugfest/tor-controller](https://github.com/bugfest/tor-controller)

## How to

```bash
$ make
```