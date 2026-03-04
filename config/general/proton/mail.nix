{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonMailSvg = builtins.path {
    path = ./icons/mail.svg;
    name = "proton-mail.svg";
  };
  protonMailWrapper = pkgs.writeShellScriptBin "proton-mail" ''
    exec ${browser}/bin/${browser.meta.mainProgram} \
      --force-dark-mode \
      --class=proton-mail \
      --app-id=proton-mail \
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
