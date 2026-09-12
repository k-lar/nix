{ lib, pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
    inputs.noctalia.homeModules.default
    ./modules/cursor.nix
    ./modules/packages-linux.nix
    ./modules/packages-gaming.nix
    ./modules/dotfiles-linux.nix
    ./modules/wallpapers.nix
  ];

  home.homeDirectory = "/home/klar";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  home.packages =
    lib.optionals (pkgs ? kvantum) [ pkgs.kvantum ]
    ++ lib.optionals (pkgs ? kdePackages && pkgs.kdePackages ? qtstyleplugin-kvantum) [
      pkgs.kdePackages.qtstyleplugin-kvantum
    ]
    ++ lib.optionals (pkgs ? libsForQt5 && pkgs.libsForQt5 ? qtstyleplugin-kvantum) [
      pkgs.libsForQt5.qtstyleplugin-kvantum
    ]
    ++ lib.optionals (pkgs ? qt6Packages && pkgs.qt6Packages ? qtstyleplugin-kvantum) [
      pkgs.qt6Packages.qtstyleplugin-kvantum
    ];

  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark-gtk";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "gruvbox-dark-icons-gtk";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    gtk2.extraConfig = ''
      gtk-theme-name = "gruvbox-dark-gtk";
      gtk-application-prefer-dark-theme = 1
    '';
    gtk3.extraConfig = {
      gtk-theme-name = "gruvbox-dark-gtk";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-theme-name = "gruvbox-dark-gtk";
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Gruvbox-Dark
  '';

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "gruvbox-dark-gtk";
      icon-theme = "gruvbox-dark-icons-gtk";
      color-scheme = "prefer-dark";
    };
  };

  programs.noctalia = {
    enable = true;
    settings = {
      plugins.enabled = [
        "noctalia/screen_recorder"
        "yuuto/calculator"
      ];
    };
  };

  services.udiskie.enable = true;
}
