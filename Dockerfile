FROM quay.io/mynth/python:dev as builder

# Install dependencies
USER root
# hadolint ignore=DL3008,DL3015
RUN apt-get update -qq && \
    apt-get install -y binutils python3.12-dev
USER monty
COPY poetry.lock pyproject.toml /app/
RUN install-poetry-app src && \
    poetry install --with=dev

# Build vault-cli
COPY src /app/src
RUN poe build:vault-cli

# Save binary
USER root
RUN mv dist/vault-cli /usr/local/bin/
USER monty

# Create final image with vault-cli binary
FROM ubuntu:22.04
COPY --from=builder /usr/local/bin/vault-cli /usr/local/bin/vault-cli
