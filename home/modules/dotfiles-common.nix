{ lib  }:

{
  lib.mkMerge = [
    (lib.mkConfig "alacritty")
    (lib.mkConfig "emacs")
    (lib.mkConfig "fastfetch")
    (lib.mkConfig "fish")
    (lib.mkConfig "ghostty")
    (lib.mkConfig "grugmark")
    (lib.mkConfig "mpv")
    (lib.mkConfig "nano")
    (lib.mkConfig "nvim")
    (lib.mkConfig "yazi")
    (lib.mkLink ".tmux.conf" "tmux/.tmux.conf")
    (lib.mkLink ".bashrc" "bash/.bashrc")
    (lib.mkLink ".bash_aliases" "bash/.bash_aliases")
    (lib.mkLink ".zshrc" "zsh/.zshrc")
    (lib.mkLink ".zsh" "zsh/.zsh")
  ];
}
