{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww
    noctalia-shell
    rofi
    foot
    thunar

    hyprland
    hyprlock
    hypridle
    hyprpicker
    hyprcursor

    wl-clipboard
    cliphist

    grim
    slurp
    satty

    networkmanagerapplet
    brightnessctl
    udiskie
    zathura
  ];
}
