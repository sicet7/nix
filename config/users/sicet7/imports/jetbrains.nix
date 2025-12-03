{ config, lib, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { };
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = { lib, config }: {
    home.packages = with pkgs; [
      unstable.jetbrains.rider
      unstable.jetbrains.goland
      unstable.jetbrains.webstorm
      unstable.jetbrains.phpstorm
      unstable.jetbrains.datagrip
    ];
  };
}