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

  programs = {
    adb = {
      enable = true;
    };
  };

  users.users.sicet7.extraGroups = [ "adbusers" "plugdev" ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = [
    unstable.android-studio-full
  ];
}