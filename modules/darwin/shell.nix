{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish = {
    shellAliases = {
      nfu = "nix flake update ~/git/nix";
      nfc = "nix flake check ~/git/nix";
      nrs = "sudo darwin-rebuild switch --flake ~/git/nix#klar-macbook";
      nrt = "sudo darwin-rebuild check --flake ~/git/nix#klar-macbook";
    };
    interactiveShellInit = ''
      function mkdev
        set template_dir "$HOME/git/nix/templates/devshell"

        cp "$template_dir/flake.nix" ./flake.nix
        cp "$template_dir/.envrc" ./.envrc

        if command -sq direnv
            direnv allow
        end

        echo "Created dev shell template."
      end

      direnv hook fish | source
    '';
  };
  users.users.klar.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];
}
