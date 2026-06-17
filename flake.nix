{
  description = "Klar's NixOS flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
  let
    klarLib = import ./lib { inherit inputs; };

    mkSystem = system: modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs klarLib; };
        modules = modules ++ [{ nixpkgs.config.allowUnfree = true; }];
      };

    mkDarwin = system: modules:
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs klarLib; };
        modules = modules ++ [{ nixpkgs.config.allowUnfree = true; }];
      };
  in
  {
    nixosConfigurations.klar-pc = mkSystem "x86_64-linux" [
      ./hosts/desktop
      inputs.home-manager.nixosModules.default
    ];

    darwinConfigurations.klar-macbook = mkDarwin "aarch64-darwin" [
      ./hosts/macbook
      home-manager.darwinModules.home-manager
    ];
  };
}
