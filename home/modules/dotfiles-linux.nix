{ lib  }:

{
  lib.mkMerge = [
     (lib.mkConfig "boomer")
     (lib.mkConfig "bspwm")
     (lib.mkConfig "dunst")
     (lib.mkConfig "foot")
     (lib.mkConfig "hypr")
     (lib.mkConfig "kitty")
     (lib.mkConfig "rofi")
     (lib.mkConfig "satty")
     (lib.mkConfig "thunar")
     (lib.mkConfig "waybar")
     (lib.mkConfig "xsettingsd")
     (lib.mkConfig "zathura")
     (lib.mkLink ".config/gtk" "gtk/.config/gtk-3.0")
     (lib.mkLink ".Xresources" "Xresources/.Xresources")
  ];
}
