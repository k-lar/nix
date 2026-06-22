{ ... }:

{
  disko.devices.disk.main = {
    type = "disk";
    # TODO: Need to fix this when installing on actual device for the first time
    # Just a placeholder for now
    device = "/dev/disk/by-id/REPLACE_ME";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        swap = {
          size = "8G";

          content = {
            type = "swap";
            randomEncryption = false;
          };
        };

        root = {
          size = "100%";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
