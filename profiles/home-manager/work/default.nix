{ config, lib, pkgs, ... }:
{
  home.packages = [ pkgs.jitsi-meet ];
  modules.terminal.iterm2.enable = true;
}
