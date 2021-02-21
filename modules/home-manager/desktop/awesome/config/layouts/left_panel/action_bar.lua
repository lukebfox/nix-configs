local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')
local tag_list            = require('widgets.tag_list')

return function(s, panel, action_bar_width)

  local menu_icon = wibox.widget {
    widget = wibox.container.margin,
    margins = dpi(10),
    {
      widget = wibox.widget.imagebox,
      id = 'menu_btn',
      image = icons.menu,
      resize = true
    }
  }

  local open_dashboard_button = wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.background .. '66',
    {
      widget = clickable_container,
      menu_icon
    }
  }

  open_dashboard_button:buttons(
    gears.table.join(
      awful.button({}, 1, nil, function() panel:toggle() end)
    )
  )

  panel:connect_signal('opened',
    function() menu_icon.menu_btn:set_image(gears.surface(icons.close_small)) end
  )

  panel:connect_signal('closed',
    function() menu_icon.menu_btn:set_image(gears.surface(icons.menu)) end
  )

  return wibox.widget {
    id = 'action_bar',
    layout = wibox.layout.align.vertical,
    forced_width = action_bar_width,
    {
      layout = wibox.layout.fixed.vertical,
      require('widgets.search_apps')(),
      tag_list(s),
      require("widgets.xdg_folders")(),
    },
    nil,
    open_dashboard_button
  }
end
