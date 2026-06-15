{ config }:

let
  dotsDir = "${config.home.homeDirectory}/.dotfiles";
in
{
  mkLink = target: source: {
    "${target}".source =
      config.lib.file.mkOutOfStoreSymlink
      "${dotsDir}/${source}";
  };

  mkConfig = name:
    (import ./dotfiles.nix { inherit config; }).mkLink
    ".config/${name}"
    "${name}/.config/${name}";
}
