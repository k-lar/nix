{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # TODO: Put macos stuff here
  ];

  homebrew.casks = [
    "alt-tab"
    "rectangle-pro"
    "keka"
    "keycaster"
    "pearcleaner"
    "raycast"
    "windows-app"
  ];
}
