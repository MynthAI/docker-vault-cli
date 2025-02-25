FROM ubuntu:24.04 AS builder

# Install Python
# hadolint ignore=DL3008
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        binutils python3.12 python3.12-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/bin/python
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONFAULTHANDLER=1
ENV PATH=/app/.venv/bin:$PATH

# Install poetry
# hadolint ignore=DL3008,DL3009
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        python3.12-venv && \
    python3.12 -m venv /opt/poetry && \
    /opt/poetry/bin/pip install poetry && \
    ln -s /opt/poetry/bin/poetry /usr/local/bin/poetry
WORKDIR /app
RUN poetry config virtualenvs.in-project true

# Install vault-cli app
COPY poetry.lock pyproject.toml /app/
COPY src /app/src
RUN poetry install --with=dev && \
    poe build:vault-cli && \
    mv dist/vault-cli /usr/local/bin/

# Create final image with vault-cli binary
FROM ubuntu:24.04
COPY --from=builder /usr/local/bin/vault-cli /usr/local/bin/vault-cli
