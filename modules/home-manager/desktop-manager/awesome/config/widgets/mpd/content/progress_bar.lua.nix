{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-widgets-mpd-progress_bar" ''
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local progressbar = wibox.widget {
    layout = wibox.layout.stack,
    {
        widget           = wibox.widget.progressbar,
        id               = 'music_bar',
        max_value        = 100,
        forced_height    = dpi(3),
        forced_width     = dpi(100),
        color            = '#${theme.base07-hex}',
        background_color = '#${theme.base07-hex}20',
        shape            = gears.shape.rounded_bar
    }
}

return progressbar
''
