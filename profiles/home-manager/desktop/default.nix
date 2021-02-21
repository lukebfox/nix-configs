{ nixosConfig, config, lib, pkgs, ... }:
{
  modules.desktop = {
    gaming.enable = true;
    gaming.games = [ pkgs.minecraft ];
    multimedia.enable = true;
    social.enable = true;
  };
}
