local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

panel_visible = false

local right_panel = function(s)

  -- Set right panel geometry
  local panel_width = dpi(350)
  local panel_x = s.geometry.x + s.geometry.width - panel_width

  local panel = wibox {
    ontop = true,
    screen = s,
    visible = false,
    type = 'dock',
    width = panel_width,
    height = s.geometry.height,
    x = panel_x,
    y = s.geometry.y,
    bg = beautiful.background,
    fg = beautiful.fg_normal
  }

  panel.opened = false

  s.backdrop_rdb = wibox {
    ontop = true,
    screen = s,
    bg = beautiful.transparent,
    type = 'utility',
    x = s.geometry.x,
    y = s.geometry.y,
    width = s.geometry.width,
    height = s.geometry.height
  }

  panel:struts { right = 0 }

  open_panel = function()
    local focused = awful.screen.focused()
    panel_visible = true

    focused.backdrop_rdb.visible = true
    focused.right_panel.visible = true

    panel:emit_signal('opened')
  end

  close_panel = function()
    local focused = awful.screen.focused()
    panel_visible = false

    focused.right_panel.visible = false
    focused.backdrop_rdb.visible = false

    panel:emit_signal('closed')
  end

  -- Hide this panel when app dashboard is called.
  function panel:hide_dashboard() close_panel() end

  function panel:toggle()
    self.opened = not self.opened
    if self.opened then
      open_panel()
    else
      close_panel()
    end
  end


  function panel:switch_pane(mode)
    if mode == 'notif_mode' then
      -- Update Content
      panel:get_children_by_id('notif_id')[1].visible = true
      panel:get_children_by_id('pane_id')[1].visible = false
    elseif mode == 'today_mode' then
      -- Update Content
      panel:get_children_by_id('notif_id')[1].visible = false
      panel:get_children_by_id('pane_id')[1].visible = true
    end
  end

  s.backdrop_rdb:buttons(
    awful.util.table.join(
      awful.button({}, 1, function() panel:toggle() end)
    )
  )

  local separator = wibox.widget {
    widget = wibox.widget.separator,
    orientation = 'horizontal',
    opacity = 0.0,
    forced_height = 15,
  }

  local line_separator = wibox.widget {
    widget = wibox.widget.separator,
    orientation = 'horizontal',
    forced_height = dpi(1),
    span_ratio = 1.0,
    color = beautiful.groups_title_bg,
  }

  panel:setup {
    widget = wibox.container.margin,
    margins = dpi(16),
    {
      layout = wibox.layout.fixed.vertical,
      expand = 'none',
      {
        layout = wibox.layout.align.horizontal,
        expand = 'none',
        nil,
        require('widgets.info_center_switch'),
        nil
      },
      separator,
      line_separator,
      separator,
      {
        layout = wibox.layout.stack,
        -- Today Pane
        {
          layout = wibox.layout.fixed.vertical,
          id = 'pane_id',
          visible = true,
          {
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(7),
            require('widgets.user_profile'),
            require('widgets.weather'),
            require('widgets.email'),
            require('widgets.social_media'),
            require('widgets.calculator')
          }
        },
        -- Notification Center
        {
          layout = wibox.layout.fixed.vertical,
          id = 'notif_id',
          visible = false,
          require('widgets.notif_center')(s)
        }
      }
    }
  }

  return panel
end

return right_panel
