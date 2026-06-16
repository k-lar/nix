{ ... }:

{
  homebrew = {
    enable = true;

    casks = [
      "alt-tab"
      "rectangle-pro"
      "keka"
      "keycastr"
      "hiddenbar"
      "pearcleaner"
      "raycast"
      "ghostty"
      "windows-app"
      "chromium"
    ];

    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;
  };
}
