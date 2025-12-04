{ config, lib, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { };
in
{
  imports = [
    <home-manager/nixos>
  ];

  programs = {
    adb = {
      enable = true;
    };
  };

  users.users.sicet7.extraGroups = [ "adbusers" "plugdev" ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    unstable.android-studio-full
  ];
}