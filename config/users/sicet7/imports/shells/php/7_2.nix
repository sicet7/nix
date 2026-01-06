let
  pkgs = import <nixpkgs-20-03> {
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
pkgs.buildEnv {
  name = "php72-env";
  paths = [
    pkgs.php72
    composer
  ];
}
