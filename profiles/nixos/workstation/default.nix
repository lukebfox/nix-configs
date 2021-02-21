{ pkgs, ... }:
{
  imports = [
    ../misc/yubikey.nix
  ];

  modules = {
    development.enable = true;
    development.languages.nix = true;
    graphical.enable = true;
  };
}
