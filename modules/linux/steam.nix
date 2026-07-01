{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
        args = [
          "-r"
          "240"
        ];
        steamArgs = [
          "-steamdeck"
        ];
        env = {
          PATH = "/usr/bin:$PATH";
        };
      };
    };
    xwayland.enable = true;
  };
}