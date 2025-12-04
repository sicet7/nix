{ config, lib, ... }:
let
  cfg = config.sicet7;
in
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
    ./imports/git.nix
    ./imports/browser.nix
    ./imports/b64d.nix
    ./imports/shop.nix
    ./imports/starship.nix
    ./imports/tmux.nix
    ./imports/enter.nix
    ./imports/packages.nix
    ./imports/android-studio.nix
    ./imports/odbc.nix
    ./imports/programming.nix
  ];

  options = {
    sicet7.homeVersion = lib.mkOption {
      type = lib.types.str;
      default = "23.11";
      description = "Defines the home.stateVersion of the sicet7 user";
    };
  };

  config = {
    nix.settings.trusted-users = [ "root" "@wheel" ];
    users.users.sicet7 = {
      isNormalUser = true;
      description = cfg.name;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;

    home-manager.users.sicet7 = {
      home.version = cfg.homeVersion;

      home.shellAliases = {
        mv = "mv -iv";
        rm = "rm -v";
        df = "df -h";
        du = "du -hs";
      };
    };

    services.clamav.scanner.scanDirectories = [
      "/home/sicet7/Downloads"
    ];
  };
}