{ pkgs, inputs, ... }:

let
  unstable = inputs.unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
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
    unstable.orca-slicer
    onlyoffice-desktopeditors
    kid3-qt
    flac
    gapless
    qemu
    virt-viewer
    virt-manager
    file-roller
    docker
    docker-compose
    docker-buildx
    lazydocker

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
