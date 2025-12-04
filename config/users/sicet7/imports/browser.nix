{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = {
    home.packages = with pkgs; [
      google-chrome
    ];
    dconf.settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "google-chrome.desktop"
        ];
      };
    };
  };
}