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
        echo ""
        echo "Examples:"
        echo "  change php 8.2"
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

      # Find matching line: tool version storePath
      match="$(awk -v t="$tool" -v v="$ver" '$1==t && $2==v {print $3}' "${registryText}" || true)"
      if [ -z "$match" ]; then
        echo "Unknown: $tool $ver"
        echo ""
        usage
        exit 1
      fi

      # Ensure target binary exists in that env
      if [ ! -x "$match/bin/$tool" ]; then
        echo "The env for $tool $ver does not provide: $match/bin/$tool"
        echo "Tip: either add that program to the env's buildEnv paths, or map this tool/version to a different env."
        exit 1
      fi

      mkdir -p "$HOME/.local/bin"
      ln -sfn "$match/bin/$tool" "$HOME/.local/bin/$tool"

      echo "Switched $tool to $ver -> $match"
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
  ];

  # Ensure ~/.local/bin wins over system binaries
  environment.interactiveShellInit = ''
    export PATH="$HOME/.local/bin:$PATH"
  '';
}