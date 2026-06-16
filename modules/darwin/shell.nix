{ pkgs, ... }:

{
  programs.fish.enable = true;
  users.users.klar.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];
}
