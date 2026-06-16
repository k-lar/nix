{ pkgs, inputs, ... }:

{
  system.primaryUser = "klar";

  imports = [
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/shell.nix
  ];

  networking.hostName = "klar-macbook";

  system.stateVersion = 5;

  users.users.klar = {
    home = "/Users/klar";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.klar = import ../../home/darwin.nix;
  };

  system.defaults.dock.autohide = true;
}
