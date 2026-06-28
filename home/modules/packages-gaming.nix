{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gamescope-wsi
    heroic
    mangohud
    protonup-ng
    protontricks
    wine
    winetricks
    lutris
  ];
}