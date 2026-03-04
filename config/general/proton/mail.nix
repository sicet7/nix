{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonSvg = builtins.path {
    path = ./icons/mail.svg;
    name = "proton-mail-svg";
  };
  protonMailWrapper = pkgs.writeShellScriptBin "proton-mail" ''
    exec ${browser}/bin/${browser.meta.mainProgram} \
      --force-dark-mode \
      --app=https://mail.proton.me/ "$@"
  '';
  protonMailDesktop = pkgs.makeDesktopItem {
      name = "proton-mail";
      exec = "${protonMailWrapper}/bin/proton-mail";
      icon = "${protonSvg}/mail.svg";
      comment = "Secure email (web‑app)";
      desktopName = "Proton Mail";
      categories = [ "Network" "Email" ];
      startupWMClass = "ungoogled-chromium";
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonMailWrapper
    protonMailDesktop
  ];
}
