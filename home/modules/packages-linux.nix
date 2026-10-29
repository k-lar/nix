{ pkgs, inputs, ... }:

let
  unstable = inputs.unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = with pkgs; [
    awww
    btop
    gdu
    rofi
    foot
    kitty
    thunar
    ddcutil
    chromium
    dconf-editor
    nicotine-plus
    unstable.orca-slicer
    onlyoffice-desktopeditors
    pwvucontrol
    kid3-qt
    flac
    gapless
    crosspipe
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

    wl-clipboard
    cliphist

    gopls
    rustup
    grim
    slurp
    thunar
    satty
    sone
    inkscape

    networkmanagerapplet
    brightnessctl
    qbittorrent
    mpv
    yt-dlp
    loupe
    cloc

    zathura
  ];
}
