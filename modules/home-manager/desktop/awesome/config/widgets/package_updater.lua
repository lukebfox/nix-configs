local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local watch = awful.widget.watch
local dpi   = beautiful.xresources.apply_dpi

local apps                = require('configuration.apps')
local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local update_available = false
local number_of_updates_available = nil
local update_package = nil

local return_button = function()

	local widget = wibox.widget {
		layout = wibox.layout.align.horizontal,
		{
			widget = wibox.widget.imagebox,
			id     = 'icon',
			image  = icons.package,
			resize = true
		}
	}

	local widget_button = wibox.widget {
		widget = clickable_container,
		{
			widget  = wibox.container.margin,
			margins = dpi(7),
			widget
		}
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					if update_available then
						awful.spawn(apps.default.package_manager .. ' --updates', false)
					else
						awful.spawn(apps.default.package_manager, false)
					end
				end
			)
		)
	)

	awful.tooltip(
		{
			objects = {widget_button},
			mode = 'outside',
			align = 'right',
			margin_leftright = dpi(8),
			margin_topbottom = dpi(8),
			timer_function = function()
				if update_available then
					return update_package:gsub('\n$', '')
				else
					return 'We are up-to-date!'
				end
			end,
			preferred_positions = {'right', 'left', 'top', 'bottom'}
		}
	)

	watch(
		'pamac checkupdates',
		60,
		function(_, stdout)
			number_of_updates_available = tonumber(stdout:match('.-\n'):match('%d*'))
			update_package = stdout
			local icon
			if number_of_updates_available ~= nil then
				update_available = true
				icon = icons.package_up
			else
				update_available = false
				icon = icons.package
			end
			widget.icon:set_image(icon)
			collectgarbage('collect')
		end
	)

	return widget_button
end

return return_button
