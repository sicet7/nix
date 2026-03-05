{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonCalendarSvg = builtins.path {
    path = ./icons/calendar.svg;
    name = "proton-calendar.svg";
  };
  protonCalendarWrapper = pkgs.writeShellScriptBin "proton-calendar" ''
    USER_DATA_DIR="$HOME/.config/chromium-proton-calendar-profile"
    if [ ! -d "$USER_DATA_DIR" ]; then
      mkdir -p "$USER_DATA_DIR"
      chmod 700 "$USER_DATA_DIR"
    fi

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-calendar \
      --user-data-dir="$USER_DATA_DIR" \
      --force-dark-mode \
      --no-first-run \
      --no-default-browser-check \
      --app=https://calendar.proton.me/ "$@"
  '';
  protonCalendarDesktop = pkgs.makeDesktopItem {
      name = "proton-calendar";
      exec = "${protonCalendarWrapper}/bin/proton-calendar";
      icon = "${protonCalendarSvg}";
      comment = "Proton Calendar helps you stay on top of your schedule while protecting your data.";
      desktopName = "Proton Calendar";
      categories = [ "Network" "Office" "Calendar" ];
      startupWMClass = "proton-calendar";
      extraConfig = {
        "X-AppId" = "proton-calendar";
      };
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonCalendarWrapper
    protonCalendarDesktop
  ];
}
