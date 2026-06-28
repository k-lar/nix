{ lib, inputs, ... }:

{
  isLinux = pkgs: pkgs.stdenv.isLinux;
  isDarwin = pkgs: pkgs.stdenv.isDarwin;
}