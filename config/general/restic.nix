{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    restic
    restic-browser
  ];
}
