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
  ];

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

  users.users.jpappas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  networking.hostName = "nixos";
}
