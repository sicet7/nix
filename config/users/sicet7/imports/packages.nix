{ config, lib, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = {
    home.packages = with pkgs; [
      vlc
      spotify
      gimp
      insomnia
      signal-desktop
      slack
      discord
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    dig
    mysql80
    postgresql
    zip
    openssl
    gparted
    ffmpeg_7-full
    shfmt
    gnumake
    jdk
    pandoc
    lf
    unixtools.watch
    htop
    gotop
    remmina
    unstable.anydesk
    wireguard-tools
    gnupg
  ];
}