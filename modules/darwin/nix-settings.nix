{
  nix = {
    settings = {
      download-buffer-size = 524288000;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "klar" ];
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 3; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };
}


