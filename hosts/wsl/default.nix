{ pkgs, ... }:

{
  imports = [
    ../../modules/base.nix
    ../../modules/nix.nix
    ../../modules/git.nix
    ../../modules/containers.nix
    ../../modules/openssh.nix
    ../../modules/amentum.nix
     # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "jpappas";

  users.users.jpappas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}