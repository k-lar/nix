{ inputs, ... }:

{
  imports = [
    ../../hardware-configuration.nix

    ../../modules/shared/shell.nix

    ../../modules/linux/audio.nix
    ../../modules/linux/bluetooth.nix
    ../../modules/linux/hyprland.nix
    ../../modules/linux/networking.nix
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
    users.klar = import ../../home/linux.nix;
  };

  system.stateVersion = "26.05";
}
