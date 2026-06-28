{ pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
    inputs.noctalia.homeModules.default
    ./modules/cursor.nix
    ./modules/packages-linux.nix
    ./modules/packages-gaming.nix
    ./modules/dotfiles-linux.nix
    ./modules/wallpapers.nix
    ./packages/noctalia.nix
  ];

  home.homeDirectory = "/home/klar";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.portal.config.portal.hyprland.preferred = [ "hyprland" "gtk" ];
  services.udiskie.enable = true;
}
