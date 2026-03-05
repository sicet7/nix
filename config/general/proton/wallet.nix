{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonWalletSvg = builtins.path {
    path = ./icons/wallet.svg;
    name = "proton-wallet.svg";
  };
  protonWalletWrapper = pkgs.writeShellScriptBin "proton-wallet" ''
    USER_DATA_DIR="$HOME/.config/chromium-proton-wallet-profile"
    if [ ! -d "$USER_DATA_DIR" ]; then
      mkdir -p "$USER_DATA_DIR"
      chmod 700 "$USER_DATA_DIR"
    fi

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-wallet \
      --user-data-dir="$USER_DATA_DIR" \
      --force-dark-mode \
      --no-first-run \
      --no-default-browser-check \
      --app=https://wallet.proton.me/ "$@"
  '';
  protonWalletDesktop = pkgs.makeDesktopItem {
      name = "proton-wallet";
      exec = "${protonWalletWrapper}/bin/proton-wallet";
      icon = "${protonWalletSvg}";
      comment = "zero-access encrypted AI assistant by Proton";
      desktopName = "Proton Wallet";
      categories = [ "Network" "Economy" ];
      startupWMClass = "proton-wallet";
      extraConfig = {
        "X-AppId" = "proton-wallet";
      };
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonWalletWrapper
    protonWalletDesktop
  ];
}
