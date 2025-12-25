{ config, lib, pkgs, ... }:

let
  shop = pkgs.writeShellScriptBin "shop" ''
    set -euo pipefail

    if [ "$#" -lt 1 ]; then
      echo "Usage: shop <package> [package ...]"
      echo "Example: shop nodejs_22 git jq"
      exit 1
    fi

    # Keep behavior identical to your function:
    # open a zsh nix-shell with the requested packages
    exec nix-shell --command zsh --packages "$@"
  '';
in
{
  environment.systemPackages = [
    shop
  ];
}