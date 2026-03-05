{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonLumoSvg = builtins.path {
    path = ./icons/lumo.svg;
    name = "proton-lumo.svg";
  };
  protonLumoWrapper = pkgs.writeShellScriptBin "proton-lumo" ''
    USER_DATA_DIR="$HOME/.config/chromium-proton-lumo-profile"
    if [ ! -d "$USER_DATA_DIR" ]; then
      mkdir -p "$USER_DATA_DIR"
      chmod 700 "$USER_DATA_DIR"
    fi

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-lumo \
      --user-data-dir="$USER_DATA_DIR" \
      --force-dark-mode \
      --no-first-run \
      --no-default-browser-check \
      --app=https://lumo.proton.me/ "$@"
  '';
  protonLumoDesktop = pkgs.makeDesktopItem {
      name = "proton-lumo";
      exec = "${protonLumoWrapper}/bin/proton-lumo";
      icon = "${protonLumoSvg}";
      comment = "zero-access encrypted AI assistant by Proton";
      desktopName = "Proton Lumo";
      categories = [ "Network" "Education" "Chat" "ArtificialIntelligence" ];
      startupWMClass = "proton-lumo";
      extraConfig = {
        "X-AppId" = "proton-lumo";
      };
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonLumoWrapper
    protonLumoDesktop
  ];
}
