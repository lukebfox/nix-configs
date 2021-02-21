{ pkgs, ... }:
{
  imports = [
    ../misc/yubikey.nix
  ];

  modules = {
    gaming.enable = true;
    graphical.enable = true;
  };
}
