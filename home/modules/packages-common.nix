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
    fastfetch
    go
    gcc
    pandoc
    typst
    unrar
    zip
  ];
}
