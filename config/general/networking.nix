{ config, pkgs, ... }:
{
  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
}