{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonMailSvg = builtins.path {
    path = ./icons/mail.svg;
    name = "proton-mail.svg";
  };
  mkProfileIfMissing = name: ''
    PROFILE_DIR="$HOME/.config/chromium/${name}"
    if [ ! -d "$PROFILE_DIR" ]; then
      mkdir -p "$PROFILE_DIR"
      chmod 700 "$PROFILE_DIR"
    fi
  '';
  protonMailWrapper = pkgs.writeShellScriptBin "proton-mail" ''
    ${mkProfileIfMissing "proton-mail-profile"}

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-mail \
      --profile-directory="proton-mail-profile" \
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
