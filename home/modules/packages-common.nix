{ pkgs }:

{
  home.packages = with pkgs; [
    wget
    neovim
    curl
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
