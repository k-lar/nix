{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    emacs
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
    unzip
    inputs.unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode
    inputs.unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode-desktop
  ];
}
