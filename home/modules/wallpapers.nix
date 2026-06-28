{ config, lib, pkgs, ... }:

{
  home.activation.cloneWallpapers =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.home.homeDirectory}/Pictures"

      if [ ! -d "${config.home.homeDirectory}/Pictures/gruvbox_walls/.git" ]; then
        ${pkgs.git}/bin/git clone https://gitlab.com/k_lar/gruvbox_walls.git \
          "${config.home.homeDirectory}/Pictures/gruvbox_walls"
      fi
    '';

  home.packages = [
    (pkgs.writeShellScriptBin "sync-wallpapers" ''
      if [ ! -d "$HOME/Pictures/gruvbox_walls/.git" ]; then
        ${pkgs.git}/bin/git clone https://gitlab.com/k_lar/gruvbox_walls.git \
          "$HOME/Pictures/gruvbox_walls"
      fi
    '')
  ];
}
