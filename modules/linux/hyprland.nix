{ inputs, pkgs, ... }:

{
  imports = [inputs.silentSDDM.nixosModules.default];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

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
