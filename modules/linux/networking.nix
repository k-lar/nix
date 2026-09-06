{
  networking.networkmanager = {
    enable = true;
  };

  programs.winbox = {
    enable = true;
    openFirewall = true;
  };
}
