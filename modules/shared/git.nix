{ ... }:

{
  programs.git = {
    enable = true;

    userName = "K_Lar";
    userEmail = "sprogarzan@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };

    ignores = [
      ".DS_Store"
    ];
  };
}
