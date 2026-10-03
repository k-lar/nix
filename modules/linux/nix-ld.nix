{ lib, pkgs, config, ... }:

let
  nixLdLibPath = lib.makeLibraryPath config.programs.nix-ld.libraries;
  pipewireJackLib = "${pkgs.pipewire.jack}/lib";
in

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

  # Make these libraries visible for runtime-loaded Python extensions (e.g. PySide6/Shiboken)
  # in addition to generic dynamically linked binaries.
  environment.variables.LD_LIBRARY_PATH = lib.mkForce "${pipewireJackLib}:${nixLdLibPath}";
}
