{ config, lib, pkgs, ... }:
let
  fixFlameshotScript = pkgs.writeShellScriptBin "flameshot-screenshot" ''
    #!/bin/sh
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    export QT_QPA_PLATFORM="wayland"
    grimshot save output - | flameshot gui --raw -
  '';
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = { lib, config, ... }: {
    dconf.settings = {
      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot" = {
        binding = "Print";
        command = "${fixFlameshotScript}/bin/flameshot-screenshot";
        name = "flameshot";
      };
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
          savePathFixed = true;
          showHelp = false;
          filenamePattern = "%F_%H-%M-%S";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.grimshot
    pkgs.slurp
    pkgs.flameshot
    fixFlameshotScript
  ];
}