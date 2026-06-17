{ inputs, ... }:

{
  system.primaryUser = "klar";

  imports = [
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/shell.nix
    ../../modules/darwin/nix-settings.nix
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

  nix = {
    settings = {
      trusted-users = [ "root" "klar" ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      download-buffer-size = 524288000;
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 3; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };
}
