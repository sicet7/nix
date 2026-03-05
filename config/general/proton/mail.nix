{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonMailSvg = builtins.path {
    path = ./icons/mail.svg;
    name = "proton-mail.svg";
  };
  protonMailWrapper = pkgs.writeShellScriptBin "proton-mail" ''
    USER_DATA_DIR="$HOME/.config/chromium-proton-mail-profile"
    if [ ! -d "$USER_DATA_DIR" ]; then
      mkdir -p "$USER_DATA_DIR"
      chmod 700 "$USER_DATA_DIR"
    fi

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-mail \
      --user-data-dir="$USER_DATA_DIR" \
      --force-dark-mode \
      --no-first-run \
      --no-default-browser-check \
      --app=https://mail.proton.me/ "$@"
  '';
  protonMailDesktop = pkgs.makeDesktopItem {
      name = "proton-mail";
      exec = "${protonMailWrapper}/bin/proton-mail";
      icon = "${protonMailSvg}";
      comment = "Secure email (web‑app)";
      desktopName = "Proton Mail";
      categories = [ "Network" "Email" ];
      startupWMClass = "proton-mail";
      extraConfig = {
        "X-AppId" = "proton-mail";
      };
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonMailWrapper
    protonMailDesktop
  ];
}
