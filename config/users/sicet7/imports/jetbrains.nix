{ config, lib, ... }:
let
  unstable = import <nixpkgs-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = {
    home.packages = [
      unstable.jetbrains.rider
      unstable.jetbrains.goland
      unstable.jetbrains.webstorm
      unstable.jetbrains.phpstorm
      unstable.jetbrains.datagrip
    ];
  };
}