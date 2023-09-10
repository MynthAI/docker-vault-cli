# Docker vault-cli

This repository contains Docker images for vault-cli, [a 12-factor
oriented command line tool for Hashicorp
Vault](https://vault-cli.readthedocs.io/en/latest/). The images are
hosted on `quay.io/mynth/docker-vault-cli`.

## Versions

Two versions are available:

1.  Standalone: Can be used in any container.
2.  Python: Can be used in containers with Python installed.

## Usage

For the standalone version, use: `docker run
quay.io/mynth/docker-vault-cli`.

For the Python version, use: `docker run
quay.io/mynth/docker-vault-cli:python`.

## Installation

For Python containers, add the following to your Dockerfile:

    COPY --from=quay.io/mynth/docker-vault-cli:python /dist /

For other containers, add:

    COPY --from=quay.io/mynth/docker-vault-cli /usr/local/bin/vault-cli /usr/local/bin/vault-cli
