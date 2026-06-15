# TODO: SPLIT INTO MODULAR FILES IN home/ FOLDER!
# MOST OF THIS IS REDUNDANT!

{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.xorg.xcursorthemes
    pkgs.xorg.xcursorgen
    pkgs.xorg.libXcursor
    pkgs.texlivePackages.latex-bin
    pkgs.texlivePackages.latex-fonts
  ];

  home.file = {
    lib.mkMerge = [
        (lib.mkConfig "alacritty")
        (lib.mkConfig "boomer")
        (lib.mkConfig "bspwm")
        (lib.mkConfig "dunst")
        (lib.mkConfig "emacs")
        (lib.mkConfig "fastfetch")
        (lib.mkConfig "fish")
        (lib.mkConfig "foot")
        (lib.mkConfig "ghostty")
        (lib.mkConfig "grugmark")
        (lib.mkConfig "hypr")
        (lib.mkConfig "kitty")
        (lib.mkConfig "mpv")
        (lib.mkConfig "nano")
        (lib.mkConfig "nvim")
        (lib.mkConfig "rofi")
        (lib.mkConfig "satty")
        (lib.mkConfig "thunar")
        (lib.mkConfig "waybar")
        (lib.mkConfig "xsettingsd")
        (lib.mkConfig "yazi")
        (lib.mkConfig "zathura")
        (lib.mkLink ".tmux.conf" "tmux/.tmux.conf")
        (lib.mkLink ".Xresources" "Xresources/.Xresources")
        (lib.mkLink ".bashrc" "bash/.bashrc")
        (lib.mkLink ".bash_aliases" "bash/.bash_aliases")
        (lib.mkLink ".config/gtk" "gtk/.config/gtk-3.0")
        (lib.mkLink ".zshrc" "zsh/.zshrc")
        (lib.mkLink ".zsh" "zsh/.zsh")
    ];

  };

  # Commands to run when activating the configuration
  home.activation = {
      # Create git dir
      create-git-dir = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run mkdir -p git;
      '';
      # Create wallpapers dir
      create-wallpapers-dir = lib.hm.dag.entryAfter ["installPackages"] ''
        if [ -d ~/Pictures/gruvbox_walls ] ; then
          echo "Directory already exists, skipping clone";
        else
          run mkdir -p ~/Pictures/gruvbox_walls;
          PATH="${pkgs.git}/bin:${pkgs.openssh}/bin:$PATH" \
            run git clone https://gitlab.com/k_lar/gruvbox_walls.git ~/Pictures/gruvbox_walls;
          echo "Cloning gruvbox_walls repository";
        fi;
      '';
  };
}
