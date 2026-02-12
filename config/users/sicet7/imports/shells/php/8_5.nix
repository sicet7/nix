let
  pkgs = import <nixpkgs> {};
  php = pkgs.php85.buildEnv {
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
#      sqlsrv # TODO: fix these when they are not marked as broken.
#      pdo_sqlsrv
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
  name = "php85-env";
  paths = [
    php
    php.packages.composer
    pkgs.roadrunner
  ];
}
