{
  nix = {
    settings = {
      download-buffer-size = 524288000;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}


