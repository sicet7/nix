{ config, lib, pkgs, ... }:
let
  cfg = config.sicet7;
in
{
  imports = [
    <home-manager/nixos>
  ];

  options = {
    sicet7.zshInitContent = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Defines string parts, seperated by newline, that will be concatenated into the initContent of the ZSH config";
    };
  };

  config = {
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
          initContent = lib.concatStringsSep "\n" cfg.zshInitContent;
          plugins = with pkgs; [
            {
              name = "zsh-autosuggestions";
              src = fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "v0.7.1";
                sha256 = "be94f262af5981f81d0ec5b38f154013b1591f83002cc359205c843812e6e50a";
              };
            }
            {
              name = "zsh-syntax-highlighting";
              src = fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-syntax-highlighting";
                rev = "0.8.0";
                sha256 = "889756a296701e94b2625e7f1505c45bb825fd2aca6980c4b531fd7063fb88fa";
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
  };
}