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

  networking = {

      # Set hostname
      hostName = "sicet7-nixos-framework";

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