{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gamescope-wsi
    heroic
    mangohud
    protonup-ng
    protontricks
    wineWow64Packages.full
    winetricks
    lutris
    beammp-launcher
  ];
}