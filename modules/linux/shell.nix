{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish = {
    shellAliases = {
      nfu = "nix flake update ~/git/nix";
      nfc = "nix flake check ~/git/nix";
      nrs = "sudo nixos-rebuild switch --flake ~/git/nix#klar-pc";
      nrt = "sudo nixos-rebuild test --flake ~/git/nix#klar-pc";
      nrb = "sudo nixos-rebuild boot --flake ~/git/nix#klar-pc";
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
  users.defaultUserShell = pkgs.fish;
}
