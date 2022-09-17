{ lib, pkgs, config, modulesPath, ... }:
{
  imports = [
    ../../profiles/nixos/wsl
    ../../profiles/nixos/users/lukebfox/wsl.nix
  ];

  system.stateVersion = "22.05";
}
