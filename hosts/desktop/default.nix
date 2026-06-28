{ lib, inputs, ... }:

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
    ../../modules/linux/keyd.nix
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
    extraGroups = [ "networkmanager" "wheel" "docker" "keyd" ];
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
