let
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/release-24.11.tar.gz";
  }) {};
  php = pkgs.php84.buildEnv {
    extensions = { all, ... }: with all; [
      filter
      openssl
      fileinfo
      iconv
      simplexml
      tokenizer
      xmlreader
      xmlwriter
      amqp
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
pkgs.mkShell {
  name = "php";
  packages = [
    php
    php.packages.composer
    pkgs.roadrunner
  ];
}
