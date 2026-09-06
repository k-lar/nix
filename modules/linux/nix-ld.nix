{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Core runtime
    stdenv.cc.cc.lib
    zlib
    glib
    util-linux
    libgcc

    # Graphics (Wayland/X11/OpenGL/Vulkan)
    wayland
    libglvnd
    vulkan-loader
    mesa
    libgbm
    libdrm
    libxkbcommon
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb

    # UI/text rendering
    fontconfig
    freetype
    cairo
    pango
    atk
    at-spi2-atk
    at-spi2-core

    # Browser/Electron stack deps used by CEF
    nspr
    nss
    dbus
    expat
    cups

    # Audio/device integration
    alsa-lib
    udev
  ];
}
