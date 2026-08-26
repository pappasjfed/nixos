{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.jpappas =
    import ../home/jpappas.nix;
}