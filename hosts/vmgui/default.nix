{ pkgs, ... }:

{
  imports = [
    ./disco.nix
    ../../modules/base.nix
    ../../modules/nix.nix
    ../../modules/git.nix
    ../../modules/containers.nix
    ../../modules/openssh.nix
    ../../modules/btrfs.nix
    ../../modules/gui-kde.nix
  ];

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
services.open-vm-tools.enable = true;

  users.users.jpappas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  networking.hostName = "nixos-gui";
}
