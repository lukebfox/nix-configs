{ nixosConfig, config, lib, pkgs, utilities, shared, ... }:
let
  inherit (lib) fileContents;
  inherit (shared.network) domain;
  inherit (config.home) username;

  # FIXME
  mkUnsafeUserSecret = path:
    fileContents
      (../../../data/secret/user + "/${username}/${path}");
in
{
  modules = {
    gaming = {
      enable = true;
      games = [ pkgs.minecraft ];
    };
    music.enable = true;
    social.enable = true;
    desktop-environment = {
      enable = true;
      gnome.enable = true;
      multimedia.enable = true;
    };
  };
}
