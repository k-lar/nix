#!/bin/sh
set -eu

HOST=""
HOST_DIR=""
CONFIG_NAME=""
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

if [ -d "./hosts/$HOST" ]; then
  HOST_DIR="$HOST"
else
  echo "Unknown host directory: ./hosts/$HOST"
  exit 1
fi

if [ -f "./hosts/${HOST_DIR}/default.nix" ]; then
  CONFIG_NAME="$(sed -n 's/^[[:space:]]*networking\.hostName[[:space:]]*=[[:space:]]*"\([^"]*\)".*/\1/p' "./hosts/${HOST_DIR}/default.nix" | head -n 1)"
fi

if [ -z "$CONFIG_NAME" ]; then
  CONFIG_NAME="$HOST_DIR"
fi

echo "Host directory: $HOST_DIR"
echo "Configuration name: $CONFIG_NAME"
echo "OS: $OS"

FLAKE=".#$CONFIG_NAME"

# ----------------------------
# LINUX (NixOS)
# ----------------------------
if [ "$OS" = "Linux" ]; then

  printf "WARNING: This will erase the disk. Continue? [y/N] "
  read -r ans
  [ "$ans" = "y" ] || exit 1

  echo "Running Disko..."
  sudo env NIX_CONFIG="experimental-features = nix-command flakes" \
    nix run github:nix-community/disko \
    -- --mode disko "./hosts/${HOST_DIR}/disko.nix"

  if [ "$DO_HW" -eq 1 ]; then
    echo "Generating hardware configuration..."
    sudo nixos-generate-config \
      --root /mnt \
      --show-hardware-config | tee "./hosts/${HOST_DIR}/hardware-configuration.nix" >/dev/null
  fi

  echo "Installing NixOS..."
  sudo env NIX_CONFIG="experimental-features = nix-command flakes" \
    nixos-install --flake "$FLAKE"

# ----------------------------
# MACOS (nix-darwin)
# ----------------------------
elif [ "$OS" = "Darwin" ]; then

  echo "Checking nix-darwin bootstrap state..."

  if ! command -v darwin-rebuild >/dev/null 2>&1; then
    echo "nix-darwin not installed yet → bootstrapping..."

    env NIX_CONFIG="experimental-features = nix-command flakes" \
      nix run nix-darwin \
      -- switch --flake "$FLAKE"
  else
    echo "nix-darwin already installed → switching..."
    env NIX_CONFIG="experimental-features = nix-command flakes" \
      darwin-rebuild switch --flake "$FLAKE"
  fi

else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Done."
