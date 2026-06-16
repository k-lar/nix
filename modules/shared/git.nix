{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "k-lar";
        email = "sprogarzan@gmail.com";
      };

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
