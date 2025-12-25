let
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/release-25.11.tar.gz";
  }) {};
in
pkgs.buildEnv {
  name = "node20-env";
  paths = [
    pkgs.nodejs_20
  ];
}