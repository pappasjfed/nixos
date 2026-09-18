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

## Devcontainer

This repository includes a `.devcontainer` that installs single-user Nix and enables `nix-command` and `flakes` inside the container.

1. Open `/home/runner/work/nixos/nixos` in VS Code or a compatible devcontainer client.
2. Reopen the workspace in the devcontainer.
3. Wait for the image build and post-create setup to finish.
4. Run Nix commands such as:

```bash
nix --version
nix flake show .
nix build .#packages.x86_64-linux.installer-iso
```

## Installer ISO

### Build locally

Build the bootable installer ISO directly from this flake:

```bash
nix build .#packages.x86_64-linux.installer-iso
ls -lh result/iso/*.iso
```

The live ISO includes a copy of this flake at `/etc/nixos`, so you can install from the checked-out configuration after booting the image.

### Download from GitHub Actions

The `Build installer ISO` workflow runs on pushes to `flakes`, pull requests targeting `flakes`, and manual `workflow_dispatch` runs. Open the workflow run in GitHub Actions and download the `installer-iso` artifact to get the generated `.iso`.

### Boot the ISO

- Attach the `.iso` to a VM or write it to removable media for a physical machine.
- Boot the system from the ISO, preferably in UEFI mode when targeting the existing `vm` or `vmgui` layouts.
- Log in to the live environment as root, then work from `/etc/nixos`.

### Install from the live ISO

Review `hosts/<host>` and any disk or hardware-specific settings before running destructive install commands. In particular, adjust partitioning, filesystems, boot mode, and hardware modules for the machine you are installing onto.

Example placeholder partitioning and mounting flow:

```bash
parted /dev/sdX -- mklabel gpt
parted /dev/sdX -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sdX -- set 1 esp on
parted /dev/sdX -- mkpart primary 512MiB 100%
mkfs.fat -F 32 /dev/sdX1
mkfs.btrfs -f /dev/sdX2
mount /dev/sdX2 /mnt
mkdir -p /mnt/boot
mount /dev/sdX1 /mnt/boot
```

Once the target disk layout is ready, install one of the flake hosts from the copy bundled into the ISO:

```bash
cd /etc/nixos
nix flake show /etc/nixos
nixos-install --flake /etc/nixos#vm
# or
nixos-install --flake /etc/nixos#vmgui
```

If you need a different machine profile, update the flake in `/etc/nixos` (or clone a fresh copy elsewhere) before running `nixos-install`.

## GIT Deets

gpg --full-generate-key 
gpg --list-secret-keys --keyid-format LONG
pass init 3B2F8BDE7B14AEE6

gh auth login
gh auth setup-git