let
  pkgs = import <nixpkgs-21-05> {
    config = {
      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    };
  };
  php = pkgs.php73.buildEnv {
    extensions = { all, ... }: with all; [
      filter
      openssl
      fileinfo
      iconv
      simplexml
      tokenizer
      xmlreader
      xmlwriter
      bcmath
      bz2
      curl
      gd
      imap
      intl
      ldap
      mbstring
      mysqli
      mysqlnd
      pdo_mysql
      pgsql
      pdo_pgsql
      sqlsrv 
      pdo_sqlsrv
      sqlite3
      pdo_sqlite
      pdo_odbc
      mongodb
      redis
      zip
      soap
      sockets
      sodium
      pdo
      ftp
      dom
      zlib
      exif
      posix
      pcntl
      ctype
      xdebug
      gettext
      shmop
      sysvmsg
      sysvsem
      sysvshm
      imagick
      xsl
      readline
    ];
  };
in
pkgs.buildEnv {
  name = "php73-env";
  paths = [
    php
    php.packages.composer
  ];
}
