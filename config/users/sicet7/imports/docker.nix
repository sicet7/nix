{ config, lib, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  virtualisation.docker.enable = true;

  users.users.sicet7.extraGroups = [ "docker" ];

  home-manager.users.sicet7 = {
    home.shellAliases = {
      ds = "docker stats --format=\"table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\"";
    };
  };
}