{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssl
    bash-completion
    curl
    wget
    vim
    jq
    yq
    unzip
    zip
    tree
    htop
    tmux
    ripgrep
    fd
    dnsutils
    nmap
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.mtr.enable = true;
  programs.nix-ld.enable = true;

  system.stateVersion = "26.05";
}