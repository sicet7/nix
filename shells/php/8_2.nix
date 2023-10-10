let
  pkgs = import <nixpkgs> {};
  php = pkgs.php82.buildEnv {
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
      openswoole
      xsl
    ];
  };
in
pkgs.mkShell {
  name = "php";
  packages = [
    php
    php.packages.composer
  ];
}
