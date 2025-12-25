let
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/release-25.11.tar.gz";
  }) {};
in
pkgs.buildEnv {
  name = "node22-env";
  paths = [
    pkgs.nodejs_22
  ];
}