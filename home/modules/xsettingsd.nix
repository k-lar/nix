{ config, pkgs, ... }:

{
  systemd.user.services.xsettingsd = {
    Unit = {
      Description = "xsettingsd - X Settings Daemon";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd -c ${config.home.homeDirectory}/.config/xsettingsd/xsettingsd.conf";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = [ pkgs.xsettingsd ];
}
