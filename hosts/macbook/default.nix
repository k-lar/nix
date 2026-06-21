{ inputs, ... }:

{
  system.primaryUser = "klar";

  imports = [
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/shell.nix
    ../../modules/darwin/nix-settings.nix
    ../../modules/darwin/keyboard.nix
  ];

  networking.hostName = "klar-macbook";

  system.stateVersion = 5;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    dock.show-recents = false; # Don't show recent applications in the Dock
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "Nlsv";
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    screencapture.location = "~/Screenshots";
  };

  users.users.klar = {
    home = "/Users/klar";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.klar = import ../../home/darwin.nix;
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
