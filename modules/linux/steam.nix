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
          "--mangoapp"
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
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    gamemode.enable = true;
    xwayland.enable = true;
  };

  users.users.klar.extraGroups = [ "gamemode" ];
}