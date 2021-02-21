local watch     = require('awful.widget.watch')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons = require('icons')

local total_prev = 0
local idle_prev = 0

local slider = wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = 'none',
  nil,
  {
    widget           = wibox.widget.progressbar,
    id               = 'cpu_usage',
    max_value        = 100,
    value            = 29,
    forced_height    = dpi(2),
    color            = beautiful.fg_normal,
    background_color = beautiful.groups_bg,
    shape            = gears.shape.rounded_rect
  },
  nil
}

watch(
  [[bash -c "cat /proc/stat | grep '^cpu '"]],
  10,
  function(_, stdout)
    local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
      stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    slider.cpu_usage:set_value(diff_usage)

    total_prev = total
    idle_prev = idle
    collectgarbage('collect')
  end
)

local cpu_meter = wibox.widget {
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
        resize = true,
        image = icons.chart
      }
    },
    slider
  }
}

return cpu_meter
