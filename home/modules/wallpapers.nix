{ pkgs }:

{
  systemd.user.tmpfiles.rules = [
    "d %h/git 0755 klar users -"
    "d %h/Pictures/gruvbox_walls 0755 klar users -"
  ];

  home.packages = [
    (pkgs.writeShellScriptBin "sync-wallpapers" ''
      if [ ! -d "$HOME/Pictures/gruvbox_walls/.git" ]; then
        ${pkgs.git}/bin/git clone https://gitlab.com/k_lar/gruvbox_walls.git \
          "$HOME/Pictures/gruvbox_walls"
      fi
    '')
  ];
}
