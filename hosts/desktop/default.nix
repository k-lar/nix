{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/shared/fonts.nix

    ../../modules/linux/audio.nix
    ../../modules/linux/bluetooth.nix
    ../../modules/linux/disko.nix
    ../../modules/linux/shell.nix
    ../../modules/linux/hyprland.nix
    ../../modules/linux/networking.nix
    ../../modules/linux/nix-settings.nix
    ../../modules/linux/zram.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "klar-pc";

  users.users.klar = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "keyd" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users.klar = import ../../home/linux.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  system.stateVersion = "26.05";
}
