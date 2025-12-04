{ config, lib, ... }:
let
  unstable = import <nixpkgs-unstable> {
    config = config.nixpkgs.config;
  };
in {
  environment.systemPackages = [
    unstable.vscode
    unstable.code-cursor
  ];
}