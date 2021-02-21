local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local record_tbl = {}

-- Panel UI
record_tbl.screen_rec_toggle_imgbox = wibox.widget {
  widget = wibox.widget.imagebox,
  image = icons.start_recording_button,
  resize = true
}

record_tbl.screen_rec_toggle_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(7),
    record_tbl.screen_rec_toggle_imgbox
  }
}

record_tbl.screen_rec_countdown_txt = wibox.widget {
  widget = wibox.widget.textbox,
  id = 'countdown_text',
  font = 'Inter Bold 64', -- TODO font
  text = '4',
  align = 'center',
  valign = 'bottom',
  opacity = 0.0
}

record_tbl.screen_rec_main_imgbox = wibox.widget {
  widget = wibox.widget.imagebox,
  image = icons.recorder_off,
  resize = true
}

record_tbl.screen_rec_main_button = wibox.widget {
  widget = wibox.container.margin,
  margins = dpi(24),
  {
    widget = wibox.container.background,
    forced_width = dpi(200),
    forced_height = dpi(200),
    bg = beautiful.groups_bg,
    shape = gears.shape.circle,
    {
      widget = clickable_container,
      {
        widget = wibox.container.margin,
        margins = dpi(24),
        record_tbl.screen_rec_main_imgbox
      }
    }
  }
}

record_tbl.screen_rec_audio_imgbox = wibox.widget {
  widget = wibox.widget.imagebox,
  image = icons.audio,
  resize = true
}

record_tbl.screen_rec_audio_button = wibox.widget {
  widget = wibox.container.background,
  forced_width = dpi(60),
  forced_height = dpi(60),
  bg = beautiful.groups_bg,
  shape = gears.shape.circle,
  {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
      widget = clickable_container,
      {
        widget = wibox.container.margin,
        margins = dpi(16),
        record_tbl.screen_rec_audio_imgbox
      }
    },
    nil
  }
}

record_tbl.screen_rec_close_imgbox = wibox.widget {
  widget = wibox.widget.imagebox,
  image = icons.close_screen,
  resize = true
}

record_tbl.screen_rec_close_button = wibox.widget {
  widget = wibox.container.background,
  forced_width = dpi(60),
  forced_height = dpi(60),
  bg = beautiful.groups_bg,
  shape = gears.shape.circle,
  {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    nil,
    {
      widget = clickable_container,
      {
        widget = wibox.container.margin,
        margins = dpi(16),
        record_tbl.screen_rec_close_imgbox
      }
    },
    nil
  }
}

record_tbl.screen_rec_settings_imgbox = wibox.widget {
  widget = wibox.widget.imagebox,
  image = icons.settings,
  resize = true
}

record_tbl.screen_rec_settings_button = wibox.widget {
  widget = wibox.container.background,
  forced_width = dpi(60),
  forced_height = dpi(60),
  bg = beautiful.groups_bg,
  shape = gears.shape.circle,
  {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
      widget = clickable_container,
      {
        widget = wibox.container.margin,
        margins = dpi(16),
        record_tbl.screen_rec_settings_imgbox,
      }
    },
    nil
  }
}

record_tbl.screen_rec_back_imgbox = wibox.widget {
  widget = wibox.widget.imagebox,
  image = icons.left_arrow,
  resize = true
}

record_tbl.screen_rec_back_button = wibox.widget {
  widget = wibox.container.background,
  forced_width = dpi(48),
  forced_height = dpi(48),
  bg = beautiful.groups_bg,
  shape = beautiful.groups_shape_rounded_rectangle,
  {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
      widget = clickable_container,
      {
        widget = wibox.container.margin,
        margins = dpi(16),
        record_tbl.screen_rec_back_imgbox
      }
    },
    nil
  }
}

record_tbl.screen_rec_back_txt = wibox.widget {
  widget = wibox.container.margin,
  margins = dpi(5),
  {
    widget = wibox.widget.textbox,
    text = 'Back',
    font = 'Inter Bold 16', --TODO font
    align = 'left',
    valign = 'center'
  }
}

record_tbl.screen_rec_res_txt = wibox.widget {
  widget = wibox.container.margin,
  margins = dpi(5),
  {
    widget = wibox.widget.textbox,
    text = 'Resolution',
    font = 'Inter Bold 16', --TODO font
    align = 'left',
    valign = 'center'
  }
}

record_tbl.screen_rec_res_txtbox = wibox.widget {
  widget = wibox.container.background,
  forced_width = dpi(60),
  forced_height = dpi(60),
  bg = beautiful.groups_bg,
  shape = beautiful.groups_shape_rounded_rectangle,
  {
    widget = clickable_container,
    {
      widget = wibox.container.margin,
      margins = dpi(5),
      {
        widget = wibox.widget.textbox,
        id = 'res_tbox',
        markup = '<span foreground="#FFFFFF66">' .. '1366x768' .. "</span>",
        font = 'Inter Bold 16', --TODO font
        align = 'left',
        valign = 'center'
      }
    }
  }
}

record_tbl.screen_rec_offset_txt = wibox.widget {
  widget = wibox.container.margin,
  margins = dpi(5),
  {
    widget = wibox.widget.textbox,
    text = 'Offset',
    font = 'Inter Bold 16', -- TODO font
    align = 'left',
    valign = 'center'
  }
}

record_tbl.screen_rec_offset_txtbox = wibox.widget {
  widget = wibox.container.background,
  forced_width = dpi(60),
  forced_height = dpi(60),
  bg = beautiful.groups_bg,
  shape = beautiful.groups_shape_rounded_rectangle,
  {
    widget = clickable_container,
    {
      widget = wibox.container.margin,
      margins = dpi(5),
      {
        widget = wibox.widget.textbox,
        id = 'offset_tbox',
        markup = '<span foreground="#FFFFFF66">' .. '0,0' .. "</span>",
        font = 'Inter Bold 16', -- TODO font
        ellipsize = 'start',
        align = 'left',
        valign = 'center'
      }
    }
  }
}

screen.connect_signal("request::desktop_decoration", function(s)

    s.recorder_screen = wibox
    ({
        ontop = true,
        screen = s,
        type = 'dock',
        height = s.geometry.height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        bg = beautiful.background,
        fg = beautiful.fg_normal
    })

    s.recorder_screen : setup {
      layout = wibox.layout.stack,
      {
        layout = wibox.layout.align.vertical,
        id = 'recorder_panel',
        visible = true,
        expand = 'none',
        nil,
        {
          layout = wibox.layout.align.horizontal,
          expand = 'none',
          nil,
          {
            layout = wibox.layout.fixed.vertical,
            record_tbl.screen_rec_countdown_txt,
            {
              layout = wibox.layout.align.horizontal,
              record_tbl.screen_rec_settings_button,
              record_tbl.screen_rec_main_button,
              record_tbl.screen_rec_audio_button
            },
            record_tbl.screen_rec_close_button
          },
          nil
        },
        nil
      },
      {
        layout = wibox.layout.align.vertical,
        id = 'recorder_settings',
        visible = false,
        expand = 'none',
        nil,
        {
          layout = wibox.layout.align.horizontal,
          expand = 'none',
          nil,
          {
            layout = wibox.layout.fixed.vertical,
            forced_width = dpi(240),
            spacing = dpi(10),
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(10),
              record_tbl.screen_rec_back_button,
              record_tbl.screen_rec_back_txt
            },
            record_tbl.screen_rec_res_txt,
            record_tbl.screen_rec_res_txtbox,
            record_tbl.screen_rec_offset_txt,
            record_tbl.screen_rec_offset_txtbox
          },
          nil
        },
        nil
      }
                              }

end)

return record_tbl
