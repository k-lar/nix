{ pkgs, ... }:

{
  home.packages = with pkgs; [
    docker
    colima
    irssi
    # TODO: Put macos stuff here
    #karabiner-elements
  ];
}
