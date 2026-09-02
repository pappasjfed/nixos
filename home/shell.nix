{
  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -lah";
      gs = "git status";

      nrb = "sudo nixos-rebuild boot --flake ~/git/nixos-config#wsl";
    };
  };
}