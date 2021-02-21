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
    id               = 'hdd_usage',
    max_value        = 100,
    value            = 29,
    forced_height    = dpi(2),
    color            = beautiful.fg_normal,
    background_color = beautiful.groups_bg,
    shape            = gears.shape.rounded_rect,
  },
  nil
}

watch(
  [[bash -c "df -h /home|grep '^/' | awk '{print $5}'"]],
  10,
  function(_, stdout)
    local space_consumed = stdout:match('(%d+)')
    slider.hdd_usage:set_value(tonumber(space_consumed))
    collectgarbage('collect')
  end
)


local harddrive_meter = wibox.widget {
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
        image = icons.harddisk,
        resize = true
      }
    },
    slider
  }
}

return harddrive_meter
