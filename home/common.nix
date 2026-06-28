{ pkgs, ... }:

{
  imports = [
    ./modules/packages-common.nix
    ./modules/dotfiles-common.nix
    ./modules/get-dotfiles.nix

    ./../modules/shared/git.nix
    ./../modules/shared/syncthing.nix
  ];

  home.username = "klar";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.discord = {
    enable = true;
    settings = {
      debugLogging = false;
      IS_MAXIMIZED = true;
      IS_MINIMIZED = false;
      SKIP_HOST_UPDATE = true;
    };
  };

  home.stateVersion = "26.05";
}
