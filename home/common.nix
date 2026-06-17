{ ... }:

{
  imports = [
    ./modules/packages-common.nix
    ./modules/dotfiles-common.nix
    ./modules/get-dotfiles.nix

    ./../modules/shared/git.nix
  ];

  home.username = "klar";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.discord.enable = true;
  # Stop discord from trying to update in the awful linux way
  xdg.configFile = {
    "discord/settings.json".text = ''
      {
        "debugLogging": false,
        "IS_MAXIMIZED": true,
        "IS_MINIMIZED": false,
        "SKIP_HOST_UPDATE": true
      }'';
  };

  home.stateVersion = "26.05";
}
