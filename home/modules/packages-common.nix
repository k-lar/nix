{ pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    wget
    vscode
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
    obsidian
    go
    gcc
    pandoc
    typst
  ];
}
