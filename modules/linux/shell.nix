{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish = {
    shellAliases = {
      fpl = "flatpak --user list";
      fpd = "sed -n '1,120p' ~/git/nix/home/modules/flatpaks.nix";
      fplock = "flatpak-lock ~/git/nix/flatpak-lock.json";
      fplockshow = "sed -n '1,160p' ~/git/nix/flatpak-lock.json";
      fpr = "flatpak --user run";
      nfu = "nix flake update ~/git/nix";
      nfc = "nix flake check ~/git/nix";
      nrs = "sudo nixos-rebuild switch --flake ~/git/nix#klar-pc";
      nrt = "sudo nixos-rebuild test --flake ~/git/nix#klar-pc";
      nrb = "sudo nixos-rebuild boot --flake ~/git/nix#klar-pc";
      ngc = "sudo nix-collect-garbage -d; sudo nixos-rebuild boot --flake ~/git/nix#klar-pc";
    };
    shellInit = ''
      if test -n "$NIX_LD_LIBRARY_PATH"
        if set -q LD_LIBRARY_PATH
          set -gx LD_LIBRARY_PATH "$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH"
        else
          set -gx LD_LIBRARY_PATH "$NIX_LD_LIBRARY_PATH"
        end
      end

      if test -d "$HOME/.local/share/python/user/bin"
        fish_add_path --prepend "$HOME/.local/share/python/user/bin"
      end
    '';
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
