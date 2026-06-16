{ ... }:

{
  homebrew = {
    enable = true;

    casks = [
      "alt-tab"
      "rectangle-pro"
      "keka"
      "keycaster"
      "pearcleaner"
      "raycast"
      "windows-app"
    ];

    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;
  };
}
