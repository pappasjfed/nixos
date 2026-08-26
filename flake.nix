{
  description = "John's NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixos-wsl.url =
      "github:nix-community/NixOS-WSL/release-26.05";

    disko.url =
      "github:nix-community/disko";

    snapper.url =
      "github:nix-community/srvos";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  
  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    disko,
    home-manager,
    ...
  }: 
  
  let
    commonModules = [
    home-manager.nixosModules.home-manager
    ./modules/home-manager.nix
    ];  
  in
  {
    nixosConfigurations = {

      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = commonModules ++ [
          nixos-wsl.nixosModules.wsl

          ./hosts/wsl
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = commonModules ++ [
          disko.nixosModules.disko

          ./hosts/vm
        ];
      };
    };
  };
}
