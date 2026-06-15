{ inputs }:

{
  description = "Klar's NixOS flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
  let
    lib = import ./lib { inherit inputs; };

    mkSystem = system: modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs lib; };
        modules = modules;
      };

    mkDarwin = system: modules:
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs lib; };
        modules = modules;
      };
  in
  {
    nixosConfigurations.klar-nixos = mkSystem "x86_64-linux" [
      ./hosts/desktop
      inputs.home-manager.nixosModules.default
    ];

    darwinConfigurations.klar-macbook = mkDarwin "aarch64-darwin" [
      ./hosts/macbook
      home-manager.darwinModules.home-manager
    ];
  };
}
