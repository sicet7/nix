{ config, lib, pkgs, ... }:
{
  imports = [
    ./zsh.nix
  ];

  sicet7.zshInitContent = [
    ''
      b64d () {
        local len=$(( ''${#1} % 4 ))
        local padded_b64=""
        if [ ''${len} = 2 ]; then
          padded_b64="''${1}=="
        elif [ ''${len} = 3 ]; then
          padded_b64="''${1}="
        else
          padded_b64="''${1}"
        fi
        echo -n "$padded_b64" | tr -- "-_" "+/" | base64 -d
      };
    ''
  ];

}