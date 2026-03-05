{ config, pkgs, ... }:
{
  imports = [
    ./proton/mail.nix
    ./proton/pass.nix
    ./proton/lumo.nix
    ./proton/drive.nix
    ./proton/calendar.nix
  ];
}
