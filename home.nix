{ config, pkgs, lib, ... }:

let
  dotsDir = "${config.home.homeDirectory}/.dotfiles";
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "klar";
  home.homeDirectory = "/home/klar";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
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
    pkgs.swww
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
    pkgs.texlivePackages.latex-bin
    pkgs.texlivePackages.latex-fonts
    pkgs.xdg-user-dirs
    pkgs.udiskie
    pkgs.ripgrep
    pkgs.fzf
    pkgs.zathura
    pkgs.tmux

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  #   # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  #   # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  #   # # symlink to the Nix store copy.
  #   # ".screenrc".source = "dotfiles/screenrc";
  #   # ".tmux.conf".source = ".dotfiles/tmux/.tmux.conf";
  #
  #   # # You can also set the file content immediately.
  #   # ".gradle/gradle.properties".text = ''
  #   #   org.gradle.console=verbose
  #   #   org.gradle.daemon.idletimeout=3600000
  #   # '';
  # };

  # Here are dotfiles in the xdg-config directory. (~/.config)
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/klar/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Services
  services.udiskie.enable = true;
}
