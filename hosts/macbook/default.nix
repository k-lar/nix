{ inputs, ... }:

{
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
