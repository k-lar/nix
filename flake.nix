{ inputs }:
let
  lib = import ./lib { inherit inputs; };
in
{
  description = "Klar's NixOS flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    mkSystem = system: modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs lib; };
        modules = modules;
      };
  in
  {
    nixosConfigurations = {
      klar-nixos = mkSystem "x86_64-linux" [
        ./hosts/desktop
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
