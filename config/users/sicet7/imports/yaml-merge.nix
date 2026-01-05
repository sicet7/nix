{ lib, config, pkgs, ... }:

let
  cfg = config.programs.yaml-merge;

  pkg = pkgs.buildGoModule {
    pname = "yaml-merge";
    version = "0.1.0";

    # local folder with main.go + go.mod + go.sum
    src = "./go/yaml-merge";

    vendorHash = cfg.vendorHash;
    subPackages = [ "." ];

    ldflags = [ "-s" "-w" ];
  };
in
{
  options.programs.yaml-merge = {
    enable = lib.mkEnableOption "yaml-merge CLI";

    vendorHash = lib.mkOption {
      type = lib.types.str;
      default = lib.fakeHash;
      description = "Fixed-output hash for Go dependencies (vendorHash). First build tells you the right value.";
    };

    addToPath = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Add yaml-merge to the system PATH.";
    };

    package = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      description = "The built yaml-merge package.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.yaml-merge.package = pkg;
    environment.systemPackages = lib.mkIf cfg.addToPath [ cfg.package ];
  };
}