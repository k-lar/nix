{ pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "klar-nixos";

  users.users.klar = {
    isNormalUser = true;
    description = "klar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "klar" = import ./home.nix;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    chromium
    librewolf-bin
    curl
    foot
    uwsm
    fish
    sddm-sugar-dark
    libsForQt5.qt5.qtgraphicaleffects
    networkmanagerapplet
    fish
  ];

  programs.thunar.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow setting GTK themes from nix
  programs.dconf.enable = true;

  system.stateVersion = "26.05";
}
