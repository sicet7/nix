{ config, lib, pkgs, ... }:

let
  shop = pkgs.writeShellScriptBin "shop" ''
    set -euo pipefail

    usage() {
      cat <<EOF
Usage:
  shop [--channel <channel>] <package> [package ...]

Options:
  --channel <name>        Use a nix-channel (e.g. nixpkgs-unstable)
  --channel=<name>        Same as above

Examples:
  shop git jq
  shop --channel nixpkgs-unstable nodejs_22 git
  shop --channel=nixpkgs-unstable ripgrep fd
EOF
      exit 1
    }

    channel=""
    packages=()

    while [ "$#" -gt 0 ]; do
      case "$1" in
        --channel=*)
          channel="''${1#--channel=}"
          shift
          ;;
        --channel)
          [ "$#" -ge 2 ] || usage
          channel="$2"
          shift 2
          ;;
        --help|-h)
          usage
          ;;
        --*)
          echo "Unknown option: $1"
          usage
          ;;
        *)
          packages+=("$1")
          shift
          ;;
      esac
    done

    [ "''${#packages[@]}" -gt 0 ] || usage

    if [ -n "$channel" ]; then
      channel_path="$HOME/.nix-defexpr/channels/$channel"

      if [ ! -d "$channel_path" ]; then
        echo "Error: nix-channel '$channel' not found."
        echo "Available channels:"
        nix-channel --list
        exit 1
      fi

      exec nix-shell \
        -I "nixpkgs=$channel_path" \
        --command zsh \
        --packages "''${packages[@]}"
    else
      exec nix-shell \
        --command zsh \
        --packages "''${packages[@]}"
    fi
  '';
in
{
  environment.systemPackages = [
    shop
  ];
}
