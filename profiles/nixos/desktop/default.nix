{ pkgs, ... }:
{
  imports = [
    ../yubikey
  ];

  modules = {
    gaming.enable = true;
    gaming.steam.enable= true;
    graphical.enable = true;
  };
}
