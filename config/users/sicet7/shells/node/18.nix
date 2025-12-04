with import <nixpkgs> {};

mkShell {
  name = "node";
  packages = [
    nodejs_18
  ];
}
