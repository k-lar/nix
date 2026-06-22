#!/bin/sh
set -eu

HOST=""
DO_HW=0

print_help() {
  echo "Usage: $0 [--hw|-H] <host>"
  echo ""
  echo "Options:"
  echo "  --hw, -H   Generate hardware config (Linux only)"
  echo "  --help, -h Show help"
  exit 0
}

for arg in "$@"; do
  case "$arg" in
    --help|-h)
      print_help
      ;;
    --hw|-H)
      DO_HW=1
      ;;
    -*)
      echo "Unknown option: $arg"
      exit 1
      ;;
    *)
      HOST="$arg"
      ;;
  esac
done

[ -z "$HOST" ] && print_help

OS="$(uname -s)"

echo "Host: $HOST"
echo "OS: $OS"

FLAKE=".#$HOST"

# ----------------------------
# LINUX (NixOS)
# ----------------------------
if [ "$OS" = "Linux" ]; then

  printf "WARNING: This will erase the disk. Continue? [y/N] "
  read ans
  [ "$ans" = "y" ] || exit 1

  echo "Running Disko..."
  sudo nix run github:nix-community/disko \
    --extra-experimental-features "nix-command flakes" \
    -- --mode disko "./hosts/${HOST}/disko.nix"

  if [ "$DO_HW" -eq 1 ]; then
    echo "Generating hardware configuration..."
    sudo nixos-generate-config \
      --root /mnt \
      --show-hardware-config > "./hosts/${HOST}/hardware-configuration.nix"
  fi

  echo "Installing NixOS..."
  sudo nixos-install \
    --extra-experimental-features "nix-command flakes" \
    --flake "$FLAKE"

# ----------------------------
# MACOS (nix-darwin)
# ----------------------------
elif [ "$OS" = "Darwin" ]; then

  echo "Checking nix-darwin bootstrap state..."

  if ! command -v darwin-rebuild >/dev/null 2>&1; then
    echo "nix-darwin not installed yet → bootstrapping..."

    nix run nix-darwin \
      --extra-experimental-features "nix-command flakes" \
      -- switch --flake "$FLAKE"
  else
    echo "nix-darwin already installed → switching..."
    darwin-rebuild switch --flake "$FLAKE"
  fi

else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Done."
