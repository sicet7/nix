{ config, lib, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { };
in {
  environment.systemPackages = with pkgs; [
    unstable.vscode
    unstable.code-cursor
  ];
}