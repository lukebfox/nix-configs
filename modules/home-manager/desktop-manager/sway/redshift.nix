# Wayland colour management. Provides systemd unit.
{ config, lib, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (lib) mkIf;

in mkIf config.modules.desktop.sway.enable {

  services.redshift = {
    enable = true;
    package = pkgs.redshift-wlr;
    provider = "geoclue2";
    brightness.night = "0.7";
    temperature.night = 2000;
  };
}
