{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = { lib, config }: {
    home.packages = with pkgs; [
      google-chrome
    ];
  };

}