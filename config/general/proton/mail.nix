{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonSvg = builtins.path {
    path = ./icons/mail.svg;
    name = "proton-mail-svg";
  };
  protonMailWrapper = pkgs.writeShellScriptBin "proton-mail" ''
    exec ${browser}/bin/${browser.meta.mainProgram} \
      --app=https://mail.proton.me/ "$@"
  '';
in {
  environment.systemPackages = [
    browser
    protonMailWrapper
  ];

  environment.etc."xdg/applications/proton-mail.desktop".text = ''
    [Desktop Entry]
    Name=Proton Mail
    Comment=Secure email (web‑app)
    Exec=${protonMailWrapper}/bin/proton-mail
    Icon=${protonSvg}/mail.svg
    Terminal=false
    Type=Application
    Categories=Network;Email;
    StartupWMClass=ungoogled-chromium
  '';
}
