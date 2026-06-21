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

    brews = [
      "neovim"
      "eza"
      "bat"
      "fzf"
      "zoxide"
      "typst"
    ];

    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;
  };
}
