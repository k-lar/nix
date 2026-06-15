{
  imports = [
    ./common.nix
    ./modules/packages-linux.nix
  ];

  home.homeDirectory = "/home/klar";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  services.udiskie.enable = true;
}
