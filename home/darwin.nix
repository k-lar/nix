{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./modules/packages-darwin.nix
  ];

  home.homeDirectory = "/Users/klar";

  home.sessionVariables.DOCKER_HOST = "unix://${config.home.homeDirectory}/.colima/default/docker.sock";
}
