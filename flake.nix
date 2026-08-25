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
  };

  outputs = { self, nixpkgs, nixos-wsl, disko, ... }:
  {
    nixosConfigurations = {

      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl/default.nix
        ];
      };

      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          disko.nixosModules.disko
          ./hosts/framework/default.nix
        ];
      };
    };
  };
}