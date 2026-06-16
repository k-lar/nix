{ klarLib  }:

{
  lib.mkMerge = [
    (klarLib.mkConfig "alacritty")
    (klarLib.mkConfig "emacs")
    (klarLib.mkConfig "fastfetch")
    (klarLib.mkConfig "fish")
    (klarLib.mkConfig "ghostty")
    (klarLib.mkConfig "grugmark")
    (klarLib.mkConfig "mpv")
    (klarLib.mkConfig "nano")
    (klarLib.mkConfig "nvim")
    (klarLib.mkConfig "yazi")
    (klarLib.mkLink ".tmux.conf" "tmux/.tmux.conf")
    (klarLib.mkLink ".bashrc" "bash/.bashrc")
    (klarLib.mkLink ".bash_aliases" "bash/.bash_aliases")
    (klarLib.mkLink ".zshrc" "zsh/.zshrc")
    (klarLib.mkLink ".zsh" "zsh/.zsh")
  ];
}
