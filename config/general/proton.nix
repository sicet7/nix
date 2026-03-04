{ config, pkgs, ... }:
{
  imports = [
    ./proton/mail.nix
    ./proton/pass.nix
    ./proton/lumo.nix
  ];
}
