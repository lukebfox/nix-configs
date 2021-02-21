local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')


local create_open_default_button = function(s)
    s.add_button = wibox.widget {
        widget = wibox.container.margin,
        margins = dpi(4),
        {
            widget = wibox.container.background,
            bg = beautiful.transparent,
            shape = gears.shape.circle,
            {
                widget = clickable_container,
                {
                    widget = wibox.container.margin,
                    margins = dpi(4),
                    {
                        widget = wibox.widget.imagebox,
                        image = icons.plus,
                        resize = true
                    }
                }
            }
        }
    }

    s.add_button:buttons(
        gears.table.join(
            awful.button({}, 1, nil, function()
                awful.spawn(
                    awful.screen.focused().selected_tag.default_app,
                    {
                        tag = mouse.screen.selected_tag
                    }
                )
            end)
        )
    )
    return s.add_button
end

return create_open_default_button
