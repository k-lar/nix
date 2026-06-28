{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awww
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    rofi
    foot
    kitty
    thunar
    discord
    ddcutil
    quickshell
    chromium

    hyprlock
    hypridle
    hyprpicker
    wf-recorder

    gamescope-wsi
    heroic
    mangohud

    wl-clipboard
    cliphist

    grim
    slurp
    thunar
    satty

    networkmanagerapplet
    brightnessctl
    udiskie
    zathura
  ];
}
