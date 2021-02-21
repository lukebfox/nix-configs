local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

return function(_, panel)

  local search_widget = wibox.widget {
    widget = wibox.container.margin,
    left = dpi(24),
    right = dpi(24),
    forced_height = dpi(48),
    {
      layout  = wibox.layout.fixed.horizontal,
      spacing = dpi(24),
      {
        widget = wibox.container.margin,
        top    = dpi(12),
        bottom = dpi(12),
        {
          widget = wibox.widget.imagebox,
          image  = icons.magnify,
          resize = true
        }
      },
      {
        widget = wibox.widget.textbox,
        text   = 'Global Search',
        font   = 'Inter Regular 12', --TODO font
        align  = 'left',
        valign = 'center'
      }
    }
  }

  search_button = wibox.widget {
    widget = wibox.container.background,
    bg     = beautiful.groups_bg,
    shape  = beautiful.groups_shape_rounded_rectangle,
    {
      widget = clickable_container,
      search_widget
    }
  }

  search_button:buttons(
    awful.util.table.join(
      awful.button({}, 1, function() panel:run_rofi() end)
    )
  )

  function dash_card_header(text)
    return wibox.widget {
      widget = wibox.container.background,
      bg = beautiful.groups_title_bg,
      forced_height = dpi(35),
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(
          cr, width, height, true, true, false, false, beautiful.groups_radius
        )
      end,
      {
        widget = wibox.container.margin,
        left = dpi(24),
        right = dpi(24),
        {
          widget = wibox.widget.textbox,
          text = text,
          font = 'Inter Regular 12', --TODO font
          align = 'left',
          valign = 'center'
        }
      }
    }
  end

  function dash_card_body(widgets)
    return wibox.widget {
      widget = wibox.container.background,
      bg = beautiful.groups_bg,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(
          cr, width, height, false, false, true, true, beautiful.groups_radius
        )
      end,
      {
        layout = wibox.layout.fixed.vertical,
        table.unpack(widgets)
      }
    }
  end

  function dash_card(text, widgets)
    return wibox.widget {
      layout = wibox.layout.fixed.vertical,
      dash_card_header(text),
      dash_card_body(widgets)
    }
  end

  hardware_monitor = dash_card(
    "Hardware Monitor",
    {
      require('widgets.cpu_meter'),
      require('widgets.ram_meter'),
      require('widgets.temperature_meter'),
      require('widgets.harddrive_meter')
    }
  )

  -- Quick Settings

  quick_settings = dash_card(
    "Quick Settings",
    {
      require('widgets.brightness_slider'),
      require('widgets.volume_slider'),
      require('widgets.airplane_mode'),
      require('widgets.bluetooth_toggle'),
      require('widgets.blue_light')
    }
  )

  return wibox.widget {
    widget = wibox.container.margin,
    margins = dpi(16),
    {
      layout = wibox.layout.align.vertical,
      {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(7),
        search_button,
        hardware_monitor,
        quick_settings
      },
      nil,
      require('widgets.end_session')()
    }
  }
end
