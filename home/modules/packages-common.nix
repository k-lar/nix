{ pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    wget
    keepassxc
    neovim
    direnv
    nix-direnv
    tree-sitter
    discord
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
