{ config, lib, ... }:
{
  imports = [
    <home-manager/nixos>
    ../../../general/fonts.nix
    ./tmux.nix
  ];

  services.xserver.desktopManager.xterm.enable = true;

  home-manager.users.sicet7 = {

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
        binding = "<Control><Alt>t";
        command = "xterm -e tmux";
        name = "Open Terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
        ];
      };
    };
  };

  services.xserver.xresources = ''
    XTerm*faceName: SauceCodePro Nerd Font Mono
    XTerm*faceSize: 12
    XTerm*Background: Grey19
    XTerm*Foreground: white
    XTerm*VT100*selectToClipboard: true
  '';
}