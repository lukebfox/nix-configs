{ pkgs, ... }:
{
  imports = [
    ../yubikey
  ];

  modules = {
    development.enable = true;
    development.languages.nix = true;
    graphical.enable = true;
  };
}
