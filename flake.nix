{
  description = "tur3l - software lab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    config-sayf.url = "github:sdhlfqr/config-sayf";
    config-sayf.flake = false;
  };

  outputs =
    { self, nixpkgs, nixos-wsl, home-manager, config-sayf, ... }@inputs: let
        system = "x86_64-linux";
        nixosConfig = ./config.nix;
        pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.tur3l = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager

          nixosConfig

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.sayf = import config-sayf;
          }
        ];
      };

      devShells.${system}.default = import ./shell.nix { inherit pkgs; };
    };
}
