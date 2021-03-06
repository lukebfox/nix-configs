local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local time_info = {}

time_info.time_status = wibox.widget {
  widget            =  wibox.widget.textbox,
  id                = 'statustime',
  text              = '00:00',
  font              = 'Inter 8', -- TODO font
  align             = 'center',
  valign            = 'center',
  forced_height     =  dpi(10)
}

time_info.time_duration = wibox.widget {
  widget            = wibox.widget.textbox,
  id                = 'durationtime',
  text              = '00:00',
  font              = 'Inter 8', -- TODO font
  align             = 'center',
  valign            = 'center',
  forced_height     = dpi(10)
}

time_info.time_track = wibox.widget {
  layout = wibox.layout.align.horizontal,
  expand = 'none',
  time_info.time_status,
  nil,
  time_info.time_duration
}

return time_info
