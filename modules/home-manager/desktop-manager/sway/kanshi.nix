# Wayland autorandr. Provides systemd unit.
{ config, lib, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (lib) mkIf;

in mkIf config.modules.desktop.sway.enable {

  services.kanshi = {
    enable = true;
    # TODO Add profiles.
  };
}
