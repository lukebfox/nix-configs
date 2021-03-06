local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')
local notifbox_core       = require('widgets.notif_center.build_notifbox')

local clear_all_imagebox = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.widget.imagebox,
    image = icons.clear_all,
    resize = true,
    forced_height = dpi(20),
    forced_width = dpi(20)
  }
}

local clear_all_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(7),
    clear_all_imagebox
  }
}

clear_all_button:buttons(
  gears.table.join(
    awful.button({}, 1, nil, function() notifbox_core.reset_notifbox_layout() end)
  )
)

local clear_all_button_wrapped = wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = 'none',
  nil,
  {
    widget = wibox.container.background,
    bg = beautiful.groups_bg,
    shape = gears.shape.circle,
    clear_all_button
  },
  nil
}

return clear_all_button_wrapped
