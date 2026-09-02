## Inital setup

export NIX_SSL_CERT_FILE=/etc/nixos/certs/amentum-bundle.crt
export SSL_CERT_FILE=/etc/nixos/certs/amentum-bundle.crt
nix-channel --update
nixos-rebuild switch --flake ./#<CONF>

## WSL

sudo nixos-rebuild boot --flake ./#wsl
sudo nixos-rebuild boot --flake .#wsl

## Generation management

sudo nixos-rebuild list-generations
nixos-rebuild list-generations

sudo nix-env -p /nix/var/nix/profiles/system --switch-generation 16

nix eval .#nixosConfigurations.wsl.config.system.stateVersion

## Flake tests

sudo nixos-rebuild dry-build --flake .#wsl
sudo nixos-rebuild dry-build --flake .#vm

## GIT Deets

gpg --full-generate-key 
gpg --list-secret-keys --keyid-format LONG
pass init 3B2F8BDE7B14AEE6

gh auth login
gh auth setup-git