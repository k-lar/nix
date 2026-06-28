{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    ibm-plex
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    nerd-fonts.blex-mono
  ];
}
