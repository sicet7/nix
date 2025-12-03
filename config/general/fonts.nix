{ config, lib, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.sauce-code-pro
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "SourceCodePro Nerd Font" ];
    };
    fontDir.enable = true;
  };
}