{
  imports = [
    ./common.nix
    ./modules/packages-darwin.nix
  ];

  home.homeDirectory = "/Users/klar";

  home.sessionVariables = {
    HOMEBREW_NO_AUTO_UPDATE = "1";
  };

  system.activationScripts.extraUserActivation.text = ''
    launchctl setenv HOMEBREW_NO_AUTO_UPDATE 1
  '';
}
