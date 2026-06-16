{ klarLib  }:

{
  lib.mkMerge = [
     (klarLib.mkConfig "boomer")
     (klarLib.mkConfig "bspwm")
     (klarLib.mkConfig "dunst")
     (klarLib.mkConfig "foot")
     (klarLib.mkConfig "hypr")
     (klarLib.mkConfig "kitty")
     (klarLib.mkConfig "rofi")
     (klarLib.mkConfig "satty")
     (klarLib.mkConfig "thunar")
     (klarLib.mkConfig "waybar")
     (klarLib.mkConfig "xsettingsd")
     (klarLib.mkConfig "zathura")
     (klarLib.mkLink ".config/gtk" "gtk/.config/gtk-3.0")
     (klarLib.mkLink ".Xresources" "Xresources/.Xresources")
  ];
}
