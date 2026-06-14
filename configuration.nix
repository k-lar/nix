# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "klar-nixos";
  networking.wireless.enable = true;

  # Download buffer size increase to disable warnings
  nix.settings.download-buffer-size = 524288000;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "Europe/Ljubljana";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sl_SI.UTF-8";
    LC_IDENTIFICATION = "sl_SI.UTF-8";
    LC_MEASUREMENT = "sl_SI.UTF-8";
    LC_MONETARY = "sl_SI.UTF-8";
    LC_NAME = "sl_SI.UTF-8";
    LC_NUMERIC = "sl_SI.UTF-8";
    LC_PAPER = "sl_SI.UTF-8";
    LC_TELEPHONE = "sl_SI.UTF-8";
    LC_TIME = "sl_SI.UTF-8";
  };

  services.xserver.xkb = {
    layout = "si";
    variant = "";
  };

  console.keyMap = "slovene";

  users.users.klar = {
    isNormalUser = true;
    description = "klar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "klar" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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

  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  programs.hyprlock.enable = true;

  programs.thunar.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  fonts.packages = with pkgs; [
    # All nerdfonts here: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerd-fonts/manifests/fonts.json

    # Pre 25.05 nix
    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "IBMPlexMono" "Iosevka" ] ;}) # IBMPlexMono is BlexMono here for some reason
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    ibm-plex
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    nerd-fonts.blex-mono
  ];

  # Display manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-dark";
  };

  services.keyd = {
    enable = true;
    keyboards = {
      # The name is just the name of the configuration file, it does not really matter
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
        # Everything but the ID section:
        settings = {
          # The main layer, if you choose to declare it in Nix
          main = {
            # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
            capslock = "esc";
            esc = "capslock";
          };
          otherlayer = {};
        };
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
        '';
      };
    };
  };

  # Optional, but makes sure that when you type the make palm rejection work with keyd
  # https://github.com/rvaiya/keyd/issues/723
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

  # Sound config (pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.hypridle.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  # Allow setting GTK themes from nix
  programs.dconf.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}
