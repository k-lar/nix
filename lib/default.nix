{ inputs, lib }:

{
  dotfiles = import ./dotfiles.nix;

  # Detect system type from pkgs if passed, or fall back safely
  isLinux = pkgs: pkgs.stdenv.isLinux;
  isDarwin = pkgs: pkgs.stdenv.isDarwin;

  mkIfLinux = pkgs: condition: value:
    lib.mkIf (condition && pkgs.stdenv.isLinux) value;

  mkIfDarwin = pkgs: condition: value:
    lib.mkIf (condition && pkgs.stdenv.isDarwin) value;
}
