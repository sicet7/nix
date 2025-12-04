{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unixODBC
  ];

  environment.unixODBCDrivers = [
    pkgs.unixODBCDrivers.msodbcsql18
    pkgs.unixODBCDrivers.sqlite
    pkgs.unixODBCDrivers.psql
    pkgs.unixODBCDrivers.mariadb
  ];
}