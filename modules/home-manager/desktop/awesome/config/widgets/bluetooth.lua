local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local watch = awful.widget.watch
local dpi   = beautiful.xresources.apply_dpi

local apps                = require('configuration.apps')
local clickable_container = require('widgets.clickable_container_effectful')
local icons               = require("icons")

local return_button = function()

	local widget = wibox.widget {
		layout = wibox.layout.align.horizontal,
		{
			widget = wibox.widget.imagebox,
			id = 'icon',
			image = icons.bluetooth_off,
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
			awful.button({}, 1,	nil, function()	awful.spawn(apps.default.bluetooth_manager, false) end)
		)
	)

	local bluetooth_tooltip = awful.tooltip
	{
		objects = {widget_button},
		mode = 'outside',
		align = 'right',
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		preferred_positions = {'right', 'left', 'top', 'bottom'}
	}

	watch(
		'rfkill list bluetooth',
		5,
		function(_, stdout)
			local icon
			if stdout:match('Soft blocked: yes') then
				icon = icons.bluetooth_off
				bluetooth_tooltip.markup = 'Bluetooth is off'
			else
				icon = icons.bluetooth
				bluetooth_tooltip.markup = 'Bluetooth is on'
			end
			widget.icon:set_image(icon)
			collectgarbage('collect')
		end,
		widget
	)

	return widget_button

end

return return_button
