{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noctalia-shell
    rofi
    foot

    hyprland
    hyprlock
    hypridle
    hyprpicker

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
