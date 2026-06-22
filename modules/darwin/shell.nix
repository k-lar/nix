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
      direnv hook fish | source
    '';
  };
  users.users.klar.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];
}
