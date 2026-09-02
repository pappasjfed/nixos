{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    git-credential-manager
    gh
    pass
    gnupg
    pinentry-curses
  ];

  programs.gnupg.agent = {
    enable = true;

    settings = {
      default-cache-ttl = 3600;
      max-cache-ttl = 86400;
    };
  };

  environment.variables = {
    GCM_CREDENTIAL_STORE = "gpg";
  };
}