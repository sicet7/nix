{ config, lib, pkgs, ... }:
let
  php72Env = import ./php/7_2.nix;
  php73Env = import ./php/7_3.nix;
  php74Env = import ./php/7_4.nix;
  php80Env = import ./php/8_0.nix;
  php81Env = import ./php/8_1.nix;
  php82Env = import ./php/8_2.nix;
  php83Env = import ./php/8_3.nix;
  php84Env = import ./php/8_4.nix;

  node20Env = import ./node/20.nix;
  node22Env = import ./node/22.nix;
  node24Env = import ./node/24.nix;

  toolRegistry = {
    php = {
      "7.2" = php72Env;
      "7.3" = php73Env;
      "7.4" = php74Env;
      "8.0" = php80Env;
      "8.1" = php81Env;
      "8.2" = php82Env;
      "8.3" = php83Env;
      "8.4" = php84Env;
    };
    node = {
      "20" = node20Env;
      "22" = node22Env;
      "24" = node24Env;
    };
  };

  registryText = pkgs.writeText "change-tool-registry.txt" (
    let
      tools = builtins.attrNames toolRegistry;
      linesForTool = tool:
        let versions = builtins.attrNames toolRegistry.${tool};
        in builtins.map (v: "${tool} ${v} ${toolRegistry.${tool}.${v}}") versions;
    in builtins.concatStringsSep "\n" (builtins.concatLists (builtins.map linesForTool tools)) + "\n"
  );

  changeCmd = pkgs.writeShellScriptBin "change" ''
      set -euo pipefail

      usage() {
        echo "Usage: change <tool> <version>"
        echo "Example: change php 8.2"
        echo ""
        echo "Available:"
        awk '{print "  " $1 " " $2}' "${registryText}" | sort -u
      }

      if [ $# -ne 2 ]; then
        usage
        exit 1
      fi

      tool="$1"
      ver="$2"

      envPath="$(awk -v t="$tool" -v v="$ver" '$1==t && $2==v {print $3}' "${registryText}" || true)"
      if [ -z "$envPath" ]; then
        echo "Unknown: $tool $ver"
        echo ""
        usage
        exit 1
      fi

      if [ ! -x "$envPath/bin/$tool" ]; then
        echo "Env does not provide: $envPath/bin/$tool"
        exit 1
      fi

      mkdir -p "$HOME/.local/bin"

      # Switch the requested tool
      ln -sfn "$envPath/bin/$tool" "$HOME/.local/bin/$tool"

      # Helper: link optional tool if present; otherwise remove stale symlink
      link_optional() {
        local bin="$1"
        if [ -x "$envPath/bin/$bin" ]; then
          ln -sfn "$envPath/bin/$bin" "$HOME/.local/bin/$bin"
        else
          if [ -L "$HOME/.local/bin/$bin" ]; then
            rm -f "$HOME/.local/bin/$bin"
          fi
        fi
      }

      if [ "$tool" = "php" ]; then
        link_optional composer
        link_optional rr
      fi

      if [ "$tool" = "node" ]; then
        link_optional npm
        link_optional npx
        link_optional corepack
      fi

      echo "Switched $tool to $ver -> $envPath"

      # Print versions (best-effort)
      "$HOME/.local/bin/$tool" --version 2>/dev/null || "$HOME/.local/bin/$tool" -v 2>/dev/null || true
    '';
in
{
  imports = [
    <home-manager/nixos>
    ../zsh.nix
  ];

  environment.systemPackages = [
    changeCmd
    pkgs.roadrunner
  ];

  # Ensure ~/.local/bin wins over system binaries
  environment.interactiveShellInit = ''
    export PATH="$HOME/.local/bin:$PATH"
  '';
}