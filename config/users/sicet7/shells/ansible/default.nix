let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  name = "ansible";
  packages = [
    pkgs.ansible
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pymysql
      python-pkgs.cryptography
      python-pkgs.jinja2
    ]))
  ];
}
