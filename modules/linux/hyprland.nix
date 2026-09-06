{ inputs, pkgs, ... }:

{
  imports = [inputs.silentSDDM.nixosModules.default];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "gruvbox-dark-gtk";
  };

  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  services.tumbler.enable = true;

  environment.systemPackages = [ pkgs.hyprpolkitagent ];

  systemd.user.services.hyprpolkitagent = {
    description = "Hyprland Polkit authentication agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  # Screen sharing in Wayland apps (e.g., Discord) needs the system portal service.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "hyprland" "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  programs.silentSDDM = {
    enable = true;
    theme = "default";
  };
}
