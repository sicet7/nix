{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  options.sicet7.zshInitContent = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "Defines string parts, seperated by newline, that will be concatenated into the initContent of the ZSH config";
  };

  programs.zsh.enable = true;

  users.users.sicet7.shell = pkgs.zsh;

  home-manager.users.sicet7 = {
    programs.zsh = {
      enable = true;
      #enableAutosuggestions = true;
      #enableCompletion = true;
      envExtra = ''
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#606060"
      '';
      initContent = lib.concatStringsSep "\n" config.sicet7.zshInitContent;
      plugins = with pkgs; [
        {
          name = "zsh-autosuggestions";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0"; # TODO: needs updating
            sha256 = "28b518a54bb80c746e990677c39f66f5a4d6e9304a3025e5d9470a8b8b8c77bc";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1"; # TODO: needs updating.
            sha256 = "80e1b434b95a25fa2d25fb3e49484680b4cd3a718b8e8aa7529e7857d685260f";
          };
        }
        {
          name = "zsh-completions";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.35.0";
            sha256 = "1851e5663207516c32795a02a6cce09f80262cf49213c51535f4668ac9e19298";
          };
        }
      ];
      oh-my-zsh = {
        enable = true;
      };
    };
  };
}