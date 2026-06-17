{
  imports = [
    ./common.nix
    ./modules/packages-linux.nix
    ./modules/wallpapers.nix
  ];

  home.homeDirectory = "/home/klar";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  programs.thunar.enable = true;
  services.udiskie.enable = true;
}
