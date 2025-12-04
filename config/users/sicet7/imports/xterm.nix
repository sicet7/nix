{ config, lib, ... }:
{
  imports = [
    <home-manager/nixos>
    ../../../general/fonts.nix
    ./tmux.nix
  ];

  home-manager.users.sicet7 = {
    programs.kitty = {
      enable = true;
      font = {
        name = "SauceCodePro Nerd Font Mono";
        size = 12;
      };
      settings = {
        # Close window as soon as the shell/command exits
        confirm_os_window_close = 0;

        # Some nice defaults
        shell_type = "login";
        scrollback_lines = 10000;
        window_padding_width = 6;
      };
      extraConfig = ''
        background   #1e1e1e
        foreground   #d4d4d4
        selection_background #264f78
        selection_foreground #ffffff

        cursor              #aeafad
        cursor_text_color   background
      '';
    };

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
        binding = "<Control><Alt>t";
        command = "kitty -e tmux";
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