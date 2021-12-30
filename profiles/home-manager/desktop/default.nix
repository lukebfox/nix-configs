{ pkgs, ... }:
{
  modules = {
    desktop-environment = {
      enable = true;
      gnome.enable = true;
      multimedia.enable = true;
    };
    gaming = {
      enable = true;
      games = [ pkgs.minecraft ];
    };
    music.enable = true;
    social.enable = true;
  };
}
