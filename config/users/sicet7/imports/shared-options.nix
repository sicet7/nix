{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  options.sicet7.name = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Defines the name of the sicet7 user";
  };

  options.sicet7.email = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Defines the email of the sicet7 user";
  };
}