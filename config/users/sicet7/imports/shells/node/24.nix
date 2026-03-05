let
  pkgs = import <nixpkgs> {};
in
pkgs.buildEnv {
  name = "node24-env";
  paths = [
    pkgs.nodejs_24
  ];
}