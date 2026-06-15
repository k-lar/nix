# TODO: SPLIT INTO MODULAR FILES IN home/ FOLDER!
# MOST OF THIS IS REDUNDANT!

{ pkgs, lib, ... }:

{
  home.username = "klar";
  home.homeDirectory = "/home/klar";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.waybar
    pkgs.rofi-wayland
    pkgs.hyprland
    pkgs.hyprlock
    pkgs.hypridle
    pkgs.hyprpicker
    pkgs.hyprcursor
    pkgs.nodejs_23
    pkgs.go
    pkgs.eza
    pkgs.bat
    pkgs.jq
    pkgs.keyd
    pkgs.brightnessctl
    pkgs.discord
    pkgs.awww
    pkgs.gcc
    pkgs.zoxide
    pkgs.xorg.xcursorthemes
    pkgs.xorg.xcursorgen
    pkgs.xorg.libXcursor
    pkgs.tree-sitter
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.grim
    pkgs.slurp
    pkgs.satty
    pkgs.pandoc
    pkgs.typst
    pkgs.texlivePackages.latex-bin
    pkgs.texlivePackages.latex-fonts
    pkgs.xdg-user-dirs
    pkgs.udiskie
    pkgs.ripgrep
    pkgs.fzf
    pkgs.zathura
    pkgs.tmux
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

    # ".bashrc".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/bash/.bashrc";
    #
    # ".bash_aliases".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/bash/.bash_aliases";
    #
    # ".config/gtk".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/gtk/.config/gtk-3.0";
    #
    # ".mpd".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/mpd/.config/mpd";
    #
    # ".tmux.conf".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/tmux/.tmux.conf";
    #
    # ".Xresources".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/Xresources/.Xresources";
    #
    # ".zshrc".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/zsh/.zshrc";
    #
    # ".zsh".source =
    #   config.lib.file.mkOutOfStoreSymlink
    #   "${dotsDir}/zsh/.zsh";
  };

  xdg.configFile = {
    "discord/settings.json".text = ''
      {
        "debugLogging": false,
        "IS_MAXIMIZED": true,
        "IS_MINIMIZED": false,
        "SKIP_HOST_UPDATE": true
      }
    '';
  };

  # Create XDG directories in the home directory
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  services.udiskie.enable = true;
}
