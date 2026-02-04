{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-hardware/framework/13-inch/7040-amd>
    ../general/allow-unfree.nix
    ../general/bootloader.nix
    ../general/networking.nix
    ../general/locale.nix
    ../general/graphics.nix
    ../general/bluetooth.nix
    ../general/touchpad.nix
    ../general/printing.nix
    ../general/audio.nix
    ../general/fonts.nix
    ../general/nano.nix
    ../general/libreoffice.nix
    ../users/sicet7/user.nix
  ];

  # Home Manager State Version
  sicet7.homeVersion = "23.11";

  # Name
  sicet7.name = "Martin René Sørensen";

  # Email
  sicet7.email = "git@sicet7.com";

  # System State Version
  system.stateVersion = "24.05";

  networking = {

      # Set hostname
      hostName = "sicet7-nixos-framework-laptop";

      # Set additional Allowed ports
      firewall = {
        allowedTCPPorts = [
          8099
          9000
          9001
          9002
          9003
          9004
        ];
        allowedUDPPorts = [
          8099
          9000
          9001
          9002
          9003
          9004
        ];
      };
    };
}
