{
  imports = [
    ./modules/packages-common.nix
    ./../modules/shared/general.nix
    ./../modules/shared/git.nix
    ./../modules/shared/fonts.nix
    ./../modules/shared/shell.nix
  ];

  home.username = "klar";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
