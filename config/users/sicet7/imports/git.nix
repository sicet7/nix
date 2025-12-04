{ config, lib, pkgs, ... }:
let
  cfg = config.sicet7;
in
{
  imports = [
    <home-manager/nixos>
    ./shared-options.nix
  ];

  home-manager.users.sicet7 = { lib, config, ... }: {
    home.packages = with pkgs; [
      lazygit
    ];

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      aliases = {
        assume = "update-index --assume-unchanged";
        unassume = "update-index --no-assume-unchanged";
        assumed = "!git ls-files -v | grep ^h | cut -c 3-";
        ours = "!f() { git checkout --ours \$@ && git add \$@; }; f";
        theirs = "!f() { git checkout --theirs \$@ && git add \$@; }; f";
        unstage = "reset HEAD";
        recreate = "!f() { [[ -n \$@ ]] && git checkout \"\$@\" && git unpublish && git checkout master && git branch -D \"\$@\" && git checkout -b \"\$@\" && git publish; }; f";
        lcf = "diff-tree --no-commit-id --name-only -r";
        rr = "!f() { git remote update \"\$1\" --prune; }; f";
        diww = "!f() { git diff -w \"\$1^\" \"\$1\"; }; f";
        cho = "checkout";
        st = "status";
        stauts = "status";
        stuats = "status";
        sta = "status";
        chp = "cherry-pick";
        tree = "log --graph";
      };
      extraConfig = {
        core = {
          fileMode = false;
          symlinks = false;
        };
        merge = {
          ff = false;
        };
        pull = {
          ff = "only";
        };
        push = {
          autoSetupRemote = true;
        };
        init = {
          defaultBranch = "master";
        };
        pager = {
          branch = false;
        };
        safe = {
          directory = "${config.home.homeDirectory}/Dev/*";
        };
      };
    };
  };
}