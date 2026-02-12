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
#      amqp # TODO: fix this when not broken
      bcmath
      bz2
      curl
      gd
#      imap # TODO: fix this when not broken
      intl
      ldap
      mbstring
      mysqli
      mysqlnd
      pdo_mysql
      pgsql
      pdo_pgsql
#      sqlsrv # TODO: fix this when not broken
#      pdo_sqlsrv # TODO: fix this when not broken
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
#      xdebug # TODO: fix this when not broken
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
