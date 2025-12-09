{ config, lib, pkgs, ... }:
let
  fixFlameshotScript = pkgs.writeShellScriptBin "flameshot-screenshot" ''
    #!/bin/sh
    flameshot gui
  '';
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.sicet7 = { lib, config, ... }: {

    home.packages = with pkgs; [
      flameshot
    ];

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

  environment.variables = rec {
    QT_QPA_PLATFORM="wayland";
  };

  environment.systemPackages = with pkgs; [
    fixFlameshotScript
  ];
}