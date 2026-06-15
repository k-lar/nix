{ pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../hardware-configuration.nix
      ../../modules/linux/audio.nix
      ../../modules/linux/bluetooth.nix
      ../../modules/linux/hyprland.nix
      ../../modules/linux/networking.nix

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    chromium
    librewolf-bin
  ];

  programs.thunar.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "26.05";
}
