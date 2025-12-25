{ config, lib, pkgs, ... }:
let
  dotnetPkg = pkgs.dotnetCorePackages.sdk_8_0;
in
{
  imports = [
    ./zsh.nix
  ];

  sicet7.zshInitContent = [
    ''
      export PATH="$PATH:/home/sicet7/.dotnet/tools"
    ''
  ];

  environment.systemPackages = with pkgs; [
    go
    dotnetPkg
    mono
    nodejs_20
  ];

  environment.variables = rec {
    DOTNET_ROOT="${dotnetPkg}";
  };
}