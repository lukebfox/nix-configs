-- This returns the "Wow, such empty." message.
local beautiful   = require('beautiful')
local wibox       = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons = require('icons')

local empty_notifbox = wibox.widget {
  widget  = wibox.container.margin,
  margins = dpi(20),
  {
    layout  = wibox.layout.fixed.vertical,
    spacing = dpi(5),
    {
      layout = wibox.layout.align.horizontal,
      expand = 'none',
      nil,
      {
        widget        = wibox.widget.imagebox,
        image         = icons.empty_notification,
        resize        = true,
        forced_height = dpi(35),
        forced_width  = dpi(35)
      },
      nil
    },
    {
      widget = wibox.widget.textbox,
      text   = 'Wow, such empty.',
      font   = 'Inter Bold 14', -- TODO font
      align  = 'center',
      valign = 'center'
    },
    {
      widget = wibox.widget.textbox,
      text   = 'Come back later.',
      font   = beautiful.font,
      align  = 'center',
      valign = 'center'
    }
  }
}


local separator_for_empty_msg =  wibox.widget {
  widget      = wibox.widget.separator,
  orientation = 'vertical',
  opacity     = 0.0
}

-- Make empty_notifbox center
local centered_empty_notifbox = wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = 'none',
  separator_for_empty_msg,
  empty_notifbox,
  separator_for_empty_msg
}

return centered_empty_notifbox
