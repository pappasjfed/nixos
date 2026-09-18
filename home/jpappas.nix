{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./vim.nix
    ./tmux.nix
  ];

  home.username = "jpappas";
  home.homeDirectory = "/home/jpappas";

  home.stateVersion = "26.05";
}