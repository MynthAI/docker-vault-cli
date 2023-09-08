FROM quay.io/mynth/python:dev as builder

# Install dependencies
COPY poetry.lock pyproject.toml /app/
RUN install-poetry-app src

# Save vault-cli file structure
# hadolint ignore=DL3003
RUN mkdir -p dist/usr/local/bin && \
    mkdir dist/usr/local/src && \
    cp -r .venv dist/usr/local/src/vault-cli && \
    cd dist/usr/local/bin && \
    ln -s ../src/vault-cli/bin/vault-cli vault-cli && \
    sed -i '1c\#!/usr/local/src/vault-cli/bin/python' \
        ../src/vault-cli/bin/vault-cli

# Create final image with vault-cli installed
FROM quay.io/mynth/python:base
COPY --from=builder /app/dist /
