{ pkgs, ... }:

{
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/a7a0d13f-c39b-4927-a4e9-87704e73a5b0";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=60" ];
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/a6691a46-2a59-4b56-9380-3578c58b01c8";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=60" ];
  };

  # SMB/CIFS mounts.
  # Update NAS host and share names, then create the credentials file:
  #   sudo install -m 600 -o root -g root /dev/null /etc/nixos/smb-credentials
  #   sudoedit /etc/nixos/smb-credentials
  # with:
  #   username=YOUR_SMB_USER
  #   password=YOUR_SMB_PASSWORD
  #   domain=WORKGROUP
  fileSystems."/mnt/nas-shared" = {
    device = "//192.168.1.100/shared";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/smb-credentials"
      "uid=klar"
      "gid=users"
      "file_mode=0664"
      "dir_mode=0775"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
      "x-systemd.mount-timeout=30"
      "nofail"
      "_netdev"
    ];
  };

  fileSystems."/mnt/nas-personal" = {
    device = "//192.168.1.100/klar";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/smb-credentials"
      "uid=klar"
      "gid=users"
      "file_mode=0664"
      "dir_mode=0775"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
      "x-systemd.mount-timeout=30"
      "nofail"
      "_netdev"
    ];
  };

  # Ensure mountpoints always exist.
  systemd.tmpfiles.rules = [
    "d /mnt/games 0755 root root -"
    "d /mnt/storage 0755 root root -"
    "d /mnt/nas-shared 0775 klar users -"
    "d /mnt/nas-personal 0775 klar users -"
  ];

  boot.supportedFilesystems = [ "cifs" ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}