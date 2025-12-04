{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ../../../general/fonts.nix
  ];

  services.xserver.enable = true;

  services.desktopManager.gnome.enable = true;

  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };

  home-manager.users.sicet7 = { lib, ... }: {
    home.shellAliases = {
      gedit = "gnome-text-editor";
    };

    dconf.settings = {
      "org/gnome/TextEditor" = {
        custom-font = "SauceCodePro Nerd Font Semi-Bold 12";
        highlight-current-line = false;
        indent-style = "space";
        show-grid = false;
        show-map = false;
        style-scheme = "Adwaita-dark";
        tab-width = lib.hm.gvariant.mkUint32 4;
        use-system-font = false;
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };
      "org/gnome/desktop/interface" = {
        clock-show-seconds = true;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        document-font-name = "Source Code Pro 11";
        enable-hot-corners = false;
        font-antialiasing = "rgba";
        font-hinting = "slight";
        font-name = "Source Code Pro 11";
        gtk-theme = "Adwaita-dark";
      };
      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
      };
      "org/gnome/desktop/screensaver" = {
        lock-enabled = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "close,minimize,maximize:appmenu";
      };
      "org/gnome/nautilus/preferences" = {
        search-filter-time-type = "last_modified";
      };
      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "interactive";
        sleep-inactive-ac-type = "nothing";
      };
      "org/gnome/mutter" = {
        workspaces-only-on-primary = true;
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/tweaks" = {
        show-extensions-notice = false;
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
        ];
      };
    };
  };

  programs.dconf.enable = true;
  programs.xwayland.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.gnome-tour         # guided tour and greeter
    pkgs.epiphany           # web browser
    pkgs.totem              # video player
    pkgs.cheese             # photo booth
    pkgs.simple-scan        # document scanner
    pkgs.geary              # email client
    pkgs.seahorse           # password manager
    pkgs.gedit              # old text editor
    pkgs.gnome-connections  # "New" RDP client that does not work.
  ];

  environment.systemPackages = with pkgs; [
    # Install Gnome Packages.
    baobab           # disk usage analyzer
    eog              # image viewer
    yelp             # help viewer
    evince           # document viewer
    file-roller      # archive manager

    # more gnome apps
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    gnome-tweaks
    gnome-screenshot
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}