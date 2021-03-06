local watch     = require('awful.widget.watch')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons = require('icons')

local slider = wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = 'none',
  nil,
  {
    widget           = wibox.widget.progressbar,
    id               = 'temp_status',
    max_value        = 100,
    value            = 29,
    forced_height    = dpi(2),
    color            = beautiful.fg_normal,
    background_color = beautiful.groups_bg,
    shape            = gears.shape.rounded_rect,
  },
  nil
}

local max_temp = 80

watch(
  'bash -c "cat /sys/class/thermal/thermal_zone0/temp"',
  5,
  function(_, stdout)
    local temp = stdout:match('(%d+)')
    slider.temp_status:set_value((temp / 1000) / max_temp * 100)
    collectgarbage('collect')
  end
)


local temperature_meter = wibox.widget {
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
      {
        widget = wibox.widget.imagebox,
        image = icons.thermometer,
        resize = true
      }
    },
    slider
  }
}

return temperature_meter
