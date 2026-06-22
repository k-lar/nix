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
  };
  users.defaultUserShell = pkgs.fish;
}
