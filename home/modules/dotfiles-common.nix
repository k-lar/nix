{ config, lib, ... }:

let
  dotsDir = "${config.home.homeDirectory}/.dotfiles";

  mkConfig = name: {
    ".config/${name}".source =
      config.lib.file.mkOutOfStoreSymlink
        "${dotsDir}/${name}/.config/${name}";
  };

  mkLink = target: source: {
    ${target}.source =
      config.lib.file.mkOutOfStoreSymlink
        "${dotsDir}/${source}";
  };
in
{
  home.file = lib.mkMerge [
    (mkConfig "alacritty")
    (mkConfig "emacs")
    (mkConfig "fastfetch")
    (mkConfig "fish")
    (mkConfig "ghostty")
    (mkConfig "grugmark")
    (mkConfig "mpv")
    (mkConfig "nano")
    (mkConfig "nvim")
    (mkConfig "yazi")
    (mkLink ".tmux.conf" "tmux/.tmux.conf")
    (mkLink ".bashrc" "bash/.bashrc")
    (mkLink ".bash_aliases" "bash/.bash_aliases")
    (mkLink ".zshrc" "zsh/.zshrc")
    (mkLink ".zsh" "zsh/.zsh")
  ];
}
