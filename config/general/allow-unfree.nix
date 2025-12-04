{ config, pkgs, ... }:
{
  # Allow unfree packages
  config.nixpkgs.config.allowUnfree = true;
}