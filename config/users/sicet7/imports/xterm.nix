{ config, lib, ... }:
{
  imports = [
    <home-manager/nixos>
    ../../../general/fonts.nix
    ./tmux.nix
  ];

  home-manager.users.sicet7 = {

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
        binding = "<Control><Alt>t";
        command = ''
          xterm \
            -xrm "XTerm*faceName: SauceCodePro Nerd Font Mono" \
            -xrm "XTerm*faceSize: 12" \
            -xrm "XTerm*Background: Grey19" \
            -xrm "XTerm*Foreground: white" \
            -xrm "XTerm*VT100*selectToClipboard: true" \
            -e tmux
        '';
        name = "Open Terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
        ];
      };
    };
  };
}