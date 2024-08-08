# Build stage
FROM ghcr.io/webassembly/wasi-sdk AS build

WORKDIR /app

RUN apt-get update \
  && apt-get install -y curl \
  && curl -L https://github.com/wasix-org/wasix-libc/releases/download/v2024-07-08.1/sysroot.tar.gz -o wasi-sysroot.tar.gz \
  && tar -xzf wasi-sysroot.tar.gz

# Final stage
FROM ghcr.io/webassembly/wasi-sdk

WORKDIR /app

ENV PATH=$PATH:/opt/wasi-sdk/bin
COPY --from=build /app/wasix-sysroot /opt/wasix-sysroot

