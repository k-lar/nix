{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    git
    tmux
    ripgrep
    fzf
    zoxide
    bat
    eza
    jq
    nodejs
    go
    gcc
    pandoc
    typst
  ];
}
