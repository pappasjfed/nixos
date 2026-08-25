# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
environment.systemPackages = with pkgs; [
  git
  git-lfs
  git-credential-manager
  curl
  wget
  vim
  jq
  yq
  unzip
  zip
  tree
  htop
  gnupg
  openssl
  bash-completion
  podman
  podman-compose
  skopeo
  tmux
  ripgrep
  fd
  dnsutils
  nmap
  pass
  gnupg
];

users.users.nixos = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
};

programs.mtr.enable = true;

virtualisation.podman = {
    enable = true;
    dockerCompat = true;
};

environment.variables = {
  SSL_CERT_FILE = "/etc/nixos/certs/ca-bundle.crt";
  NIX_SSL_CERT_FILE = "/etc/nixos/certs/ca-bundle.crt";
  GCM_CREDENTIAL_STORE = "gpg";  
  EDITOR = "vim";
  VISUAL= "vim";
};

services.openssh = {
  enable = true;
  settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };
};

security.pki.certificates = [
  (builtins.readFile /etc/nixos/certs/amentum_decryption.cer)
  (builtins.readFile /etc/nixos/certs/amentumrootca2022.cer)
  (builtins.readFile /etc/nixos/certs/proxy_services.cer)
  ];

imports = [
  # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix.settings = {
    experimental-features = [
	"nix-command"
	"flakes"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
