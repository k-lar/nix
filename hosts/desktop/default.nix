{ inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../hardware-configuration.nix
      ../../modules/linux/audio.nix
      ../../modules/linux/bluetooth.nix
      ../../modules/linux/hyprland.nix
      ../../modules/linux/networking.nix
      ../../modules/shared/shell.nix

      inputs.home-manager.nixosModules.default
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "klar-nixos";

  users.users.klar = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.klar = import ../../home/linux.nix;
  };

  system.stateVersion = "26.05";
}
