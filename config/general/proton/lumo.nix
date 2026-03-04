{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonLumoSvg = builtins.path {
    path = ./icons/lumo.svg;
    name = "proton-lumo.svg";
  };
  protonLumoWrapper = pkgs.writeShellScriptBin "proton-lumo" ''
    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-lumo \
      --profile-directory="proton-lumo-profile" \
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
      categories = [ "Network" "Chat" "ArtificialIntelligence" ];
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
