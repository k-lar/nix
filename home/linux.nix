{ pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
    inputs.noctalia.homeModules.default
    ./modules/packages-linux.nix
    ./modules/dotfiles-linux.nix
    ./modules/wallpapers.nix
    ./packages/noctalia.nix
  ];

  home.homeDirectory = "/home/klar";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  services.udiskie.enable = true;
}
