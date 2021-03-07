# Wayland notification daemon.
{ config, lib, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (lib) mkIf;

in mkIf config.modules.desktop-manager.sway.enable {

  programs.mako = {
    enable = true;
    maxVisible = 3;
    defaultTimeout = 3000;
    ignoreTimeout = true;
    lowUrgency = {
      backgroundColor = "#${theme.base00-hex}";
      textColor       = "#${theme.base05-hex}";
      borderColor     = "#${theme.base0D-hex}";
    };
    normalUrgency = {
      backgroundColor = "#${theme.base00-hex}";
      textColor       = "#${theme.base05-hex}";
      borderColor     = "#${theme.base0D-hex}";
    };
    highUrgency = {
      backgroundColor = "#${theme.base00-hex}";
      textColor       = "#${theme.base05-hex}";
      borderColor     = "#${theme.base0D-hex}";
    };
    hiddenFormat = "<span align='center'>(%h more)</span>";
  };
}
