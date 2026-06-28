{
  description = "Klar's NixOS flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "unstable";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    mkSystem = system: modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = modules ++ [{ nixpkgs.config.allowUnfree = true; }];
      };

    mkDarwin = system: modules:
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = modules ++ [{ nixpkgs.config.allowUnfree = true; }];
      };
  in
  {
    nixosConfigurations.klar-pc = mkSystem "x86_64-linux" [
      ./hosts/desktop
      inputs.home-manager.nixosModules.default
      inputs.disko.nixosModules.disko
    ];

    darwinConfigurations.klar-macbook = mkDarwin "aarch64-darwin" [
      ./hosts/macbook
      home-manager.darwinModules.home-manager
    ];
  };
}
