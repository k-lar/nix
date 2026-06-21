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
      "tailscale-app"
    ];

    # Formulae (idk why they're called brews)
    brews = [];

    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;
  };
}
