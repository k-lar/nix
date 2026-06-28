{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awww
    btop
    gdu
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    rofi
    foot
    kitty
    thunar
    ddcutil
    quickshell
    chromium

    hyprlock
    hypridle
    hyprpicker
    wf-recorder

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
