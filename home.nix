{ config, pkgs, lib, ... }:

let
  dotsDir = "${config.home.homeDirectory}/.dotfiles";

  mkConfigLink = name: {
    ".config/${name}".source =
      config.lib.file.mkOutOfStoreSymlink
      "${dotsDir}/${name}/.config/${name}";
  };

  mkTargetLink = { target, source ? target, base ? dotsDir }: {
    "${target}".source =
      config.lib.file.mkOutOfStoreSymlink "${base}/${source}";
  };
in

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
    lib.mkMerge [
        (mkConfigLink "alacritty")
        (mkConfigLink "boomer")
        (mkConfigLink "bspwm")
        (mkConfigLink "dunst")
        (mkConfigLink "emacs")
        (mkConfigLink "fastfetch")
        (mkConfigLink "fish")
        (mkConfigLink "foot")
        (mkConfigLink "ghostty")
        (mkConfigLink "grugmark")
        (mkConfigLink "hypr")
        (mkConfigLink "kitty")
        (mkConfigLink "mpv")
        (mkConfigLink "nano")
        (mkConfigLink "nvim")
        (mkConfigLink "rofi")
        (mkConfigLink "satty")
        (mkConfigLink "thunar")
        (mkConfigLink "waybar")
        (mkConfigLink "xsettingsd")
        (mkConfigLink "yazi")
        (mkConfigLink "zathura")

        (mkTargetLink {
          target = ".tmux.conf";
          source = "tmux/.tmux.conf";
        })

        (mkTargetLink {
          target = ".Xresources";
          source = "Xresources/.Xresources";
        })

        (mkTargetLink {
          target = ".bashrc";
          source = "bash/.bashrc";
        })

        (mkTargetLink {
          target = ".bash_aliases";
          source = "bash/.bash_aliases";
        })

        (mkTargetLink {
          target = ".config/gtk";
          source = "gtk/.config/gtk-3.0";
        })

        (mkTargetLink {
          target = ".zshrc";
          source = "zsh/.zshrc";
        })

        (mkTargetLink {
          target = ".zsh";
          source = "zsh/.zsh";
        })
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

  programs.git.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  services.udiskie.enable = true;
}
