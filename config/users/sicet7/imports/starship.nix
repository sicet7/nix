{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = {
    programs.starship = {
      enable = true;
      settings = {
        time = {
          disabled = false;
          use_12hr = false;
        };
        nix_shell = {
          format = "$state ";
          impure_msg = "[\\[](bold red)[\$name](bold blue)[\\]](bold red)";
          pure_msg = "[\\[](bold green)[\$name](bold blue)[\\]](bold green)";
          unknown_msg = "[\\[](bold yellow)[\$name](bold blue)[\\]](bold yellow)";
        };
        sudo = {
          disabled = false;
        };
      };
    };
  };
}