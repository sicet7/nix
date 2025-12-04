{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./zsh.nix
  ];

  home-manager.users.sicet7 = {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      historyLimit = 10000;
      escapeTime = 0;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "screen-256color";
      extraConfig = ''
        # Prevent tmux from renaming my windows.
        set-option -g allow-rename off
        # Start new windows and panes from the same path
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        # Change panes with <LALT>+<Arrow Keys>
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
        # Next and previous windows on <prefix>(h or j)
        bind h previous-window
        bind j next-window
        # bind T to top current window
        bind-key T swap-window -t 1
        # Copy Tmux buffer to system buffer with xclip (<prefix> + y)
        bind y run "tmux save-buffer - | xsel -ib"
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-battery false
            set -g @dracula-show-network false
            set -g @dracula-show-weather false
            set -g @dracula-military-time true
            set -g @dracula-show-timezone false
            set -g @dracula-cpu-usage true
            set -g @dracula-ram-usage true
            set -g @dracula-day-month true
            set -g @dracula-plugins "cpu-usage ram-usage time"
            set -g @dracula-left-icon-padding 1
          '';
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    xsel
  ];
}