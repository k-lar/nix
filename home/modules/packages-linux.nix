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
    dconf-editor
    nicotine-plus
    orca-slicer
    kid3-qt
    flac
    gapless
    qemu
    virt-viewer
    virt-manager

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
    qbittorrent
    mpv
    loupe
    cloc

    zathura
  ];
}
