{ config, lib, pkgs, ... }:

let
  b64d = pkgs.writeShellScriptBin "b64d" ''
    set -euo pipefail

    # Usage:
    #   b64d <base64url>
    #   echo <base64url> | b64d
    #
    # Decodes base64url (-_) with optional missing padding.

    input="''${1:-}"
    if [ -z "$input" ]; then
      # allow stdin if no arg given
      input="$(cat)"
    fi

    # pad to a multiple of 4
    len=$(( ''${#input} % 4 ))
    padded="$input"
    if [ "$len" = 2 ]; then
      padded="''${input}=="
    elif [ "$len" = 3 ]; then
      padded="''${input}="
    fi

    # translate base64url to standard base64 and decode
    printf "%s" "$padded" | tr -- "-_" "+/" | ${pkgs.coreutils}/bin/base64 -d
  '';
in
{
  environment.systemPackages = [
    b64d
  ];
}