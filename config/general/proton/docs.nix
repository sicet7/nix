{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonDocsSvg = builtins.path {
    path = ./icons/docs.svg;
    name = "proton-docs.svg";
  };
  protonDocsWrapper = pkgs.writeShellScriptBin "proton-docs" ''
    USER_DATA_DIR="$HOME/.config/chromium-proton-docs-profile"
    if [ ! -d "$USER_DATA_DIR" ]; then
      mkdir -p "$USER_DATA_DIR"
      chmod 700 "$USER_DATA_DIR"
    fi

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-docs \
      --user-data-dir="$USER_DATA_DIR" \
      --force-dark-mode \
      --no-first-run \
      --no-default-browser-check \
      --app=https://docs.proton.me/ "$@"
  '';
  protonDocsDesktop = pkgs.makeDesktopItem {
      name = "proton-docs";
      exec = "${protonDocsWrapper}/bin/proton-docs";
      icon = "${protonDocsSvg}";
      comment = "zero-access encrypted AI assistant by Proton";
      desktopName = "Proton Docs";
      categories = [ "Network" "Office" "Spreadsheet" "WordProcessor" ];
      startupWMClass = "proton-docs";
      extraConfig = {
        "X-AppId" = "proton-docs";
      };
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonDocsWrapper
    protonDocsDesktop
  ];
}
