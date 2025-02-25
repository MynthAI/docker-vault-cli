# Docker vault-cli

This repository contains a Linux-based Docker image for `vault-cli`, [a
12-factor oriented command line tool for Hashicorp
Vault](https://vault-cli.readthedocs.io/en/latest/). The image is hosted
on `quay.io/mynth/docker-vault-cli`.

## Usage

`vault-cli` is available as a standalone binary in
`quay.io/mynth/docker-vault-cli`.

## Installation into Another Container

Add the following to your Dockerfile:

    COPY --from=quay.io/mynth/docker-vault-cli /usr/local/bin/vault-cli /usr/local/bin/vault-cli
