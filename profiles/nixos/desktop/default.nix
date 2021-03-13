{ pkgs, ... }:
{
  imports = [
    ../misc/yubikey.nix
  ];

  modules = {
    gaming.enable = true;
    gaming.steam.enable= true;
    graphical.enable = true;
  };
}
