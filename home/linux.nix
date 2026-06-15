{
  imports = [
    ./common.nix
    ./modules/packages-linux.nix
    ./modules/wallpapers.nix
  ];

  home.homeDirectory = "/home/klar";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # Stop discord from trying to update in the awful linux way
  xdg.configFile = {
    "discord/settings.json".text = ''
      {
        "debugLogging": false,
        "IS_MAXIMIZED": true,
        "IS_MINIMIZED": false,
        "SKIP_HOST_UPDATE": true
      }'';
  };

  programs.thunar.enable = true;
  services.udiskie.enable = true;
}
