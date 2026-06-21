{ config, lib, ...}:

{
  home.activation.createSyncthingDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.home.homeDirectory}/Important"
    '';

  services.syncthing = {
    enable = true;
    settings = {
      gui.user = "klar";
      devices = {
        "failnot" = { id = "YDTSAYB-IMDGIOS-XCXKMED-QPQGQFG-HTNMDHS-SNC3BBW-G6JERQO-RUMDQAZ"; };
      };
      folders = {
        "Important" = {
          path = "${config.home.homeDirectory}/Important";
          devices = [ "failnot" ];
        };
        # "Example" = {
        #   path = "${config.home.homeDirectory}/Example";
        #   devices = [ "device1" ];
        #   ignorePerms = false; # Enable file permission syncing
        # };
      };
    };
  };
}