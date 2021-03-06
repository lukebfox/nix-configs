local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local apps                = require('configuration.apps')
local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local return_button = function()

	local widget = wibox.widget {
		layout = wibox.layout.align.horizontal,
		{
			widget = wibox.widget.imagebox,
			id = 'icon',
			image = icons.app_launcher,
			resize = true
		}
	}

	local widget_button = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(10),
			widget
		}
	}

	widget_button:buttons(
		gears.table.join(
			awful.button({}, 1,	nil, function()
				if screen.primary.left_panel.opened then
					screen.primary.left_panel:toggle()
				end
				awful.spawn(apps.default.rofi_appmenu, false)
			end)
		)
	)

	return widget_button
end

return return_button
