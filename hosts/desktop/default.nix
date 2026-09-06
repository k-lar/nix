{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./other-disks.nix

    ../../modules/shared/fonts.nix
    ../../modules/shared/gtk.nix

    ../../modules/linux/audio.nix
    ../../modules/linux/bluetooth.nix
    ../../modules/linux/locale.nix
    ../../modules/linux/shell.nix
    ../../modules/linux/hyprland.nix
    ../../modules/linux/flatpak.nix
    ../../modules/linux/keyd.nix
    ../../modules/linux/nix-ld.nix
    ../../modules/linux/networking.nix
    ../../modules/linux/nix-settings.nix
    ../../modules/linux/steam.nix
    ../../modules/linux/zram.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "klar-pc";

  users.users.klar = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "keyd" "input" ];
  };

  security.polkit.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/klar/.steam/compatibilitytools.d";
  };

  hardware.i2c.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    };

  services.xserver.videoDrivers = [ "amdgpu" ];

  security.wrappers.gsr-kms-server = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
  };

  virtualisation.docker.enable = true;

  # Logitech G29 wheel support
  hardware.new-lg4ff.enable = true;
  services.udev.packages = [ pkgs.oversteer ];
  environment.systemPackages = with pkgs; [
    oversteer
    gpu-screen-recorder
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.klar = {
      imports = [ ../../home/linux.nix ];
    };
  };

  system.stateVersion = "26.05";
}
