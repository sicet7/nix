{ config, lib, pkgs, ... }:
{
  # Enable Touchpad support.
  services.libinput.enable = true;
}