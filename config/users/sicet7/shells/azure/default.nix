let
  pkgs = import <nixpkgs> { };
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
pkgs.mkShell {
  name = "azure";
  packages = [
    unstable.azure-cli
  ];
}
