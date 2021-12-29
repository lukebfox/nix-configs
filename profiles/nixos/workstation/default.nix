{ pkgs, ... }:
{
  imports = [
    ../yubikey
  ];

  modules = {
    development.enable = true;
    graphical.enable = true;
  };
}
