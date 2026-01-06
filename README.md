# My Nix Configuration

```shell
sudo nix-channel --add https://nixos.org/channels/nixos-20.03 nixpkgs-20-03
sudo nix-channel --add https://nixos.org/channels/nixos-21.05 nixpkgs-21-05
sudo nix-channel --add https://nixos.org/channels/nixos-22.05 nixpkgs-22-05
sudo nix-channel --add https://nixos.org/channels/nixos-23.05 nixpkgs-23-05
sudo nix-channel --add https://nixos.org/channels/nixos-24.11 nixpkgs-24-11

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-25.11 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-25.11 nixpkgs
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
```