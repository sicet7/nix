{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./zsh.nix
  ];

  sicet7.zshInitContent = [
    ''
      enter () {
        local shellFile="default.nix"
        if [ $# -lt 1 ] || [ $# -ge 3 ]; then
            echo "Invalid amount of arguments."
            return 1
        fi
        if [ $# -eq 2 ]; then
          local shellVersion="$2"
          shellFile="''${shellVersion/\./_}.nix"
        fi
        local shellFilePath="$HOME/.my-nix-shells/$1/$shellFile"
        if [ -f "$shellFilePath" ]; then
          nix-shell --command zsh "$shellFilePath"
          return 0
        fi
        echo "$shellFilePath does not exist"
        return 1
      };
    ''
  ];

  home-manager.users.sicet7 = {
    home.file = let
      myShells = builtins.path { path = ../shells; };
    in {
      ".my-nix-shells".source = "${myShells}";
    };
  };
}