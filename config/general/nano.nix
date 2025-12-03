{ config, lib, pkgs, ... }:
{
  programs.nano = {
    nanorc = ''
      set autoindent
      set tabsize 4
      set tabstospaces
      set numbercolor white
    '';
    syntaxHighlight = true;
  };
}