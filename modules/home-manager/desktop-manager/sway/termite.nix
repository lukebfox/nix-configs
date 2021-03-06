# Simple terminal emulator.
{ config, lib, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (lib) mkIf;

in mkIf config.modules.desktop.sway.enable {

  # Configure environmental variables.
  home.sessionVariables.TERMINAL = "${pkgs.termite}/bin/termite";
  home.sessionVariables.TERM = "termite";

  programs.termite = {
    enable = true;
    allowBold = true;
    clickableUrl = true;
    font = "Fura Code NerdFont 11"; # TODO define value with nixosConfig option
    iconName = "terminal";
    scrollbackLines = 10000;
    cursorShape = "block";
    colorsExtra  = ''
      foreground = #${theme.base05-hex}
      foreground_bold = #${theme.base05-hex}
      cursor = #${theme.base05-hex}
      cursor_foreground = #${theme.base00-hex}
      background = #${theme.base00-hex}
      color0  = #${theme.base00-hex}
      color1  = #${theme.base08-hex}
      color2  = #${theme.base0B-hex}
      color3  = #${theme.base0A-hex}
      color4  = #${theme.base0D-hex}
      color5  = #${theme.base0E-hex}
      color6  = #${theme.base0C-hex}
      color7  = #${theme.base05-hex}
      color8  = #${theme.base03-hex}
      color9  = #${theme.base08-hex}
      color10 = #${theme.base0B-hex}
      color11 = #${theme.base0A-hex}
      color12 = #${theme.base0D-hex}
      color13 = #${theme.base0E-hex}
      color14 = #${theme.base0C-hex}
      color15 = #${theme.base07-hex}
      color16 = #${theme.base09-hex}
      color17 = #${theme.base0F-hex}
      color18 = #${theme.base01-hex}
      color19 = #${theme.base02-hex}
      color20 = #${theme.base04-hex}
      color21 = #${theme.base06-hex}
    '';
  };
}
