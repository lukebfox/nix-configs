local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local return_button = function()

	local widget = wibox.widget {
		layout = wibox.layout.align.horizontal,
		{
			widget = wibox.widget.imagebox,
			id = 'icon',
			image = icons.info-center,
			resize = true
		}
	}

	local widget_button = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(7),
			widget
		}
	}

	widget_button:buttons(
		gears.table.join(
			awful.button({}, 1,	nil, function()	awful.screen.focused().right_panel:toggle()	end)
		)
	)

	return widget_button
end

return return_button
