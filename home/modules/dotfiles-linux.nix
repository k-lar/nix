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

  mkLinkForce = target: source: {
    ${target} = {
      force = true;
      source =
        config.lib.file.mkOutOfStoreSymlink
          "${dotsDir}/${source}";
    };
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
    (mkConfig "waybar")
    (mkConfig "xsettingsd")
    (mkConfig "zathura")
    (mkLink ".local/share/rofi/themes/rounded-gruvbox.rasi" "rofi/.local/share/rofi/themes/rounded-gruvbox.rasi")
    (mkLink ".local/state/noctalia/settings.toml" "noctalia/.local/state/noctalia/settings.toml")
    (mkLinkForce ".config/Thunar/uca.xml" "thunar/.config/Thunar/uca.xml")
  ];
}