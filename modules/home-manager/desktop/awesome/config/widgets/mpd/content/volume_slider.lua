{ config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-widgets-mpd-volume-slider" ''
local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')

local dpi = require('beautiful').xresources.apply_dpi

local slider = {}

slider.vol_slider = wibox.widget {
  bar_shape           = gears.shape.rounded_rect,
  bar_height          = dpi(5),
  bar_color           = '#${theme.base07-hex}20',
  bar_active_color    = '#${theme.base07-hex}EE',
  handle_color        = '#${theme.base07-hex}',
  handle_shape        = gears.shape.circle,
  handle_width        = dpi(15),
  handle_border_color = '#${theme.base00-hex}12',
  handle_border_width = dpi(1),
  maximum             = 100,
  widget              = wibox.widget.slider,
}

return slider
