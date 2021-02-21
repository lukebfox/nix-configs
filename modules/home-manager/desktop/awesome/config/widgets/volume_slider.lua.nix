{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-widgets-volume_slider" ''
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local spawn = awful.spawn
local dpi   = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local icon = wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = 'none',
  nil,
  {
    widget = wibox.widget.imagebox,
    image = icons.volume,
    resize = true
  },
  nil
}

local action_level = wibox.widget {
  widget = wibox.container.background,
  bg = beautiful.transparent,
  shape = gears.shape.circle,
  {
    widget = clickable_container,
    icon
  }
}

local slider = wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = 'none',
  forced_height = dpi(24),
  nil,
  {
    widget              = wibox.widget.slider,
    id                  = 'volume_slider',
    bar_shape           = gears.shape.rounded_rect,
    bar_height          = dpi(2),
    bar_color           = '#${theme.base07-hex}20',
    bar_active_color    = '#${theme.base07-hex}EE',
    handle_color        = '#${theme.base07-hex}',
    handle_shape        = gears.shape.circle,
    handle_width        = dpi(15),
    handle_border_color = '#${theme.base00-hex}12',
    handle_border_width = dpi(1),
    maximum             = 100
  },
  nil
}

local volume_slider = slider.volume_slider

volume_slider:connect_signal('property::value', function()
  local volume_level = volume_slider:get_value()
  spawn('amixer -D default sset Master ' .. volume_level .. '%', false)
  awesome.emit_signal('component::volume_osd', volume_level) -- Updates volume osd
end)

volume_slider:buttons(
  gears.table.join(
    awful.button({}, 4,
      nil,
      function()
        if volume_slider:get_value() > 100 then
          volume_slider:set_value(100)
          return
        end
        volume_slider:set_value(volume_slider:get_value() + 5)
      end
    ),
    awful.button({}, 5,
      nil,
      function()
        if volume_slider:get_value() < 5 then
          volume_slider:set_value(5)
          return
        end
        volume_slider:set_value(volume_slider:get_value() - 5)
      end
    )
  )
)


local update_slider = function()
  awful.spawn.easy_async_with_shell(
    "bash -c 'amixer -D default sget Master'",
    function(stdout)
      local volume = string.match(stdout, '(%d?%d?%d)%%')
      volume_slider:set_value(tonumber(volume))
    end
  )
end

-- Update on startup
update_slider()

local action_jump = function()
  local sli_value = volume_slider:get_value()
  local new_value = 0

  if sli_value >= 0 and sli_value < 50 then
    new_value = 50
  elseif sli_value >= 50 and sli_value < 100 then
    new_value = 100
  else
    new_value = 0
  end
  volume_slider:set_value(new_value)
end

action_level:buttons(
  awful.util.table.join(
    awful.button({}, 1, nil, function() action_jump() end)
  )
)

-- The emit will come from the global keybind
awesome.connect_signal('widget::volume', function() update_slider() end)

-- The emit will come from the OSD
awesome.connect_signal('widget::volume:update', function(value)
  volume_slider:set_value(tonumber(value))
end)

local volume_setting = wibox.widget {
  widget = wibox.container.margin,
  left = dpi(24),
  right = dpi(24),
  forced_height = dpi(48),
  {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(24),
    {
      widget = wibox.container.margin,
      top = dpi(12),
      bottom = dpi(12),
      action_level
    },
    slider
  }
}

return volume_setting
''
