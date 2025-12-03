{ config, lib, ... }:
{
  imports = [
    # Requires home-manager to be in your nix-channel --list
    <home-manager/nixos>
    ./imports/shared-options.nix
    ./imports/gnome.nix
    ./imports/zsh.nix
    ./imports/xterm.nix
    ./imports/flameshot.nix
    ./imports/localsend.nix
    ./imports/docker.nix
    ./imports/jetbrains.nix
  ];

  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
    };
  };

  users.users.sicet7 = {
    isNormalUser = true;
    description = config.sicet7.name;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  options.sicet7.homeVersion = lib.mkOption {
   type = lib.types.str;
   default = "23.11";
   description = "Defines the home.stateVersion of the sicet7 user";
  };

  home-manager.users.sicet7 = {
    home.version = config.sicet7.homeVersion;

    home.shellAliases = {
      mv = "mv -iv";
      rm = "rm -v";
      df = "df -h";
      du = "du -hs";
    };
  };
}