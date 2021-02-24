{ config, lib, pkgs, ... }:
{
  home.packages = [ pkgs.jitsi-meet pkgs.zoom-us ];
}
