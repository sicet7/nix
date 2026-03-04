{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    proton-pass
    protonmail-desktop
  ];
}
