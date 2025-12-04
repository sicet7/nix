{ config, lib, pkgs, ... }:
{
  imports = [
    ./zsh.nix
  ];

  sicet7.zshInitContent = [
    ''
      shop () {
        nix-shell --command zsh --packages "$@"
      };
    ''
  ];

}