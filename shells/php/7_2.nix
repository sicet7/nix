let
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/release-20.03.tar.gz";
  }) {
    config = {
      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    }; 
  };

  composer = pkgs.stdenv.mkDerivation {
    name = "composer";
    src = pkgs.fetchurl {
      url = "https://getcomposer.org/download/2.8.8/composer.phar";
      sha256 = "sha256-lXJj4oS596E9f0ddxl82FNFRsMTcx+h2H35/dJRH+2g=";
    };

    phases = [ "installPhase" ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/composer
      chmod +x $out/bin/composer
    '';
  };
in
pkgs.mkShell {
  name = "php";
  buildInputs = [
    pkgs.php72
    composer
  ];
}
