local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local top_panel = function(s, offset)
  local offsetx = 0
  if offset == true then offsetx = dpi(60) end

  local panel = wibox {
    ontop = true,
    screen = s,
    type = 'dock',
    height = dpi(28),
    width = s.geometry.width - offsetx,
    x = s.geometry.x + offsetx,
    y = s.geometry.y,
    stretch = false,
    bg = beautiful.background,
    fg = beautiful.fg_normal,
  }

  panel:struts { top = dpi(28) }

  panel:connect_signal(
    'mouse::enter',
    function()
      local w = mouse.current_wibox
      if w then
        w.cursor = 'left_ptr'
      end
    end
  )

  s.systray = wibox.widget {
    widget     = wibox.widget.systray,
    visible    = false,
    base_size  = dpi(20),
    horizontal = true,
    screen     = 'primary',
  }

  local clock      = require('widgets.clock')(s)
  local layout_box = require('widgets.layoutbox')(s)
  local add_button = require('widgets.open_default_app')(s)

  s.tray_toggler   = require('widgets.tray_toggle')
  s.screen_rec     = require('widgets.screen_recorder')()
  s.mpd            = require('widgets.mpd')()
  s.bluetooth      = require('widgets.bluetooth')()
  s.battery        = require('widgets.battery')()
  s.network        = require('widgets.network')()

  panel:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    {
      layout = wibox.layout.fixed.horizontal,
      add_button
    },
    clock,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(5),
      {
        widget = wibox.container.margin,
        margins = dpi(5),
        s.systray,
      },
      s.tray_toggler,
      s.screen_rec,
      s.mpd,
      s.network,
      s.bluetooth,
      s.battery,
      layout_box
    }
    --]]
  }

  return panel
end

return top_panel
