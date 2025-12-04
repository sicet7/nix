{ config, lib, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = {
    home.packages = with pkgs; [
      localsend
    ];
  };

  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
}