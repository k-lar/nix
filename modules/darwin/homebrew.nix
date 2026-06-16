{ ... }:

{
  homebrew = {
    enable = true;

    casks = [
      "alt-tab"
      "rectangle-pro"
      "keka"
      "keycastr"
      "pearcleaner"
      "raycast"
      "windows-app"
      "chromium"
    ];

    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;
  };
}
