{ pkgs, ... }:

{
  home.activation.cloneDotfiles = ''
    if [ ! -d "$HOME/.dotfiles/.git" ]; then
      echo "Cloning dotfiles repo..."
      ${pkgs.git}/bin/git clone https://github.com/k-lar/dotfiles \
        "$HOME/.dotfiles"
    fi
  '';
}
