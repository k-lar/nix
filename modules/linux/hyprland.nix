{
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

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-dark";
  };
}
