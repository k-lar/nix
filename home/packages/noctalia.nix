{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      wallpaper.enabled = false;
      dock = {
        enabled = false;
      };
      noctaliaPerformance = {
        disableWallpaper = true;
      };
      general = {
        enableShadows = false;
      };
      ui = {
        panelBackgroundOpacity = 1.0;
      };
      bar = {
        density = "default";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          center = [
            {
              id = "Calendar";
            }
            {
              id = "Clock";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Tray";
            }
          ];
        };
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = true;
      };
      nightLight = {
        enabled = true;
        autoSchedule = false;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "07:30";
        manualSunset = "22:00";
      };
      colorSchemes.predefinedScheme = "Gruvbox-Material";
      location = {
        monthBeforeDay = false;
        name = "Ljubljana, Slovenia";
      };
    };
  };
}