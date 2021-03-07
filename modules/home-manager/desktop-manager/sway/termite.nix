# Simple terminal emulator.
{ config, lib, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (lib) mkIf;

in mkIf config.modules.desktop-manager.sway.enable {

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
    colorsExtra  = with theme; ''
      foreground = #${base05-hex}
      foreground_bold = #${base05-hex}
      cursor = #${base05-hex}
      cursor_foreground = #${base00-hex}
      background = #${base00-hex}
      color0  = #${base00-hex}
      color1  = #${base08-hex}
      color2  = #${base0B-hex}
      color3  = #${base0A-hex}
      color4  = #${base0D-hex}
      color5  = #${base0E-hex}
      color6  = #${base0C-hex}
      color7  = #${base05-hex}
      color8  = #${base03-hex}
      color9  = #${base08-hex}
      color10 = #${base0B-hex}
      color11 = #${base0A-hex}
      color12 = #${base0D-hex}
      color13 = #${base0E-hex}
      color14 = #${base0C-hex}
      color15 = #${base07-hex}
      color16 = #${base09-hex}
      color17 = #${base0F-hex}
      color18 = #${base01-hex}
      color19 = #${base02-hex}
      color20 = #${base04-hex}
      color21 = #${base06-hex}
    '';
  };
}
