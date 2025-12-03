{ config, lib, pkgs, ... }:
{
  imports = [
    ../general/allow-unfree.nix
    ../general/bootloader.nix
    ../general/windows-dual-boot.nix
    ../general/networking.nix
    ../general/locale.nix
    ../general/graphics.nix
    ../general/audio.nix
    ../general/fonts.nix
    ../general/nano.nix
    ../users/sicet7/user.nix
  ];

  # Set hostname
  networking.hostName = "sicet7-nixos-framework";

  # My Home Desktop has a AMD Graphics Card
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Home Manager State Version
  sicet7.homeVersion = "23.11";

  # Name
  sicet7.name = "Martin René Sørensen";

  # Email
  sicet7.email = "git@sicet7.com";

  # System State Version
  system.stateVersion = "24.05";
}