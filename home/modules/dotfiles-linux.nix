{ config, lib, ... }:

let
  dotsDir = "${config.home.homeDirectory}/.dotfiles";

  mkConfig = name: {
    ".config/${name}".source =
      config.lib.file.mkOutOfStoreSymlink
        "${dotsDir}/${name}/.config/${name}";
  };

  mkLink = target: source: {
    ${target}.source =
      config.lib.file.mkOutOfStoreSymlink
        "${dotsDir}/${source}";
  };
in
{
  home.file = lib.mkMerge [
    (mkConfig "boomer")
    (mkConfig "bspwm")
    (mkConfig "dunst")
    (mkConfig "foot")
    (mkConfig "hypr")
    (mkConfig "kitty")
    (mkConfig "rofi")
    (mkConfig "satty")
    (mkConfig "thunar")
    (mkConfig "waybar")
    (mkConfig "xsettingsd")
    (mkConfig "zathura")
    (mkLink ".config/gtk" "gtk/.config/gtk-3.0")
    (mkLink ".local/share/rofi/themes/rounded-gruvbox.rasi" "rofi/.local/share/rofi/themes/rounded-gruvbox.rasi")
  ];
}