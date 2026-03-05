{ config, pkgs, ... }:
let
  browser = pkgs.ungoogled-chromium;
  protonDriveSvg = builtins.path {
    path = ./icons/drive.svg;
    name = "proton-drive.svg";
  };
  protonDriveWrapper = pkgs.writeShellScriptBin "proton-drive" ''
    USER_DATA_DIR="$HOME/.config/chromium-proton-drive-profile"
    if [ ! -d "$USER_DATA_DIR" ]; then
      mkdir -p "$USER_DATA_DIR"
      chmod 700 "$USER_DATA_DIR"
    fi

    exec ${browser}/bin/${browser.meta.mainProgram} \
      --ozone-platform=x11 \
      --class=proton-drive \
      --user-data-dir="$USER_DATA_DIR" \
      --force-dark-mode \
      --no-first-run \
      --no-default-browser-check \
      --app=https://drive.proton.me/ "$@"
  '';
  protonDriveDesktop = pkgs.makeDesktopItem {
      name = "proton-drive";
      exec = "${protonDriveWrapper}/bin/proton-drive";
      icon = "${protonDriveSvg}";
      comment = "Securely store, share, and access your important files and photos. Anytime, anywhere.";
      desktopName = "Proton Drive";
      categories = [ "Network" "System" "FileManager" "FileTools" ];
      startupWMClass = "proton-drive";
      extraConfig = {
        "X-AppId" = "proton-drive";
      };
      type = "Application";
    };
in {
  environment.systemPackages = [
    browser
    protonDriveWrapper
    protonDriveDesktop
  ];
}
