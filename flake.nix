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
    system = "x86_64-linux";

    commonModules = [
      home-manager.nixosModules.home-manager
      ./modules/home-manager.nix
    ];

    installerConfiguration = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./modules/base.nix
        ./modules/nix.nix
        ({ lib, pkgs, ... }: {
          networking.hostName = "nixos-installer";

          environment.systemPackages = with pkgs; [
            git
          ];

          environment.etc."nixos".source = lib.mkForce self.outPath;
        })
      ];
    };
  in
  {
    nixosConfigurations = {

      wsl = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = commonModules ++ [
          nixos-wsl.nixosModules.wsl

          ./hosts/wsl
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = commonModules ++ [
          disko.nixosModules.disko

          ./hosts/vm
        ];
      };

      vmgui = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = commonModules ++ [
          disko.nixosModules.disko

          ./hosts/vmgui
        ];
      };

      installer = installerConfiguration;
    };

    packages.${system}.installer-iso =
      installerConfiguration.config.system.build.isoImage;
  };
}
