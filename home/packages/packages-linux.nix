{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    rofi-wayland

    hyprland
    hyprlock
    hypridle
    hyprpicker

    wl-clipboard
    cliphist

    grim
    slurp
    satty

    brightnessctl
    udiskie
    zathura
  ];
}
