FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /nix \
    && chown vscode:vscode /nix

USER vscode

RUN bash -lc 'curl -fsSL https://nixos.org/nix/install | sh -s -- --no-daemon'

RUN mkdir -p /home/vscode/.config/nix \
    && printf "experimental-features = nix-command flakes\n" > /home/vscode/.config/nix/nix.conf

ENV PATH=/home/vscode/.nix-profile/bin:${PATH}
