local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local watch = awful.widget.watch
local dpi   = beautiful.xresources.apply_dpi
local widget_dir = gears.filesystem.get_configuration_dir() .. 'widgets/'

local clickable_container = require('widgets.clickable_container')
local icons               = require('icons')

local ap_state = false

local action_name = wibox.widget {
	widget = wibox.widget.textbox,
	text = 'Airplane Mode',
	font = 'Inter Regular 11', --TODO font
	align = 'left',
}

local button_widget = wibox.widget {
	layout = wibox.layout.align.horizontal,
	{
		widget = wibox.widget.imagebox,
		id = 'icon',
		image = icons.toggled_off,
		resize = true,
	}
}

local widget_button = wibox.widget {
	widget = clickable_container,
	{
		widget = wibox.container.margin,
		button_widget,
		top = dpi(7),
		bottom = dpi(7),
	}
}

local update_imagebox = function()
	if ap_state then
		button_widget.icon:set_image(icons.toggled_on)
	else
		button_widget.icon:set_image(icons.toggled_off)
	end
end

local check_airplane_mode_state = function()

	local cmd = 'cat ' .. widget_dir .. 'airplane_mode'

	awful.spawn.easy_async_with_shell(
		cmd,
		function(stdout)
			local status = stdout

			if status:match("true") then
				ap_state = true
			elseif status:match("false") then
				ap_state = false
			else
				ap_state = false
				awful.spawn.easy_async_with_shell(
					'echo "false" > ' .. widget_dir .. 'airplane_mode',
					function(stdout)
					end
				)
			end

			update_imagebox()
		end
	)
end

check_airplane_mode_state()

local ap_off_cmd = [[

	rfkill unblock wlan

	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
    icons = require('icons')
	naughty.notification({
		app_name = 'Network Manager',
		title = '<b>Airplane mode disabled!</b>',
		message = 'Initializing network devices',
		icon = icons.airplane-mode-off
	})
	"
	]] .. "echo false > " .. widget_dir .. "airplane_mode" .. [[
]]

local ap_on_cmd = [[

	rfkill block wlan

	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
    icons = require('icons')
	naughty.notification({
		app_name = 'Network Manager',
		title = '<b>Airplane mode enabled!</b>',
		message = 'Disabling radio devices',
		icon = icons.airplane-mode
	})
	"
	]] .. "echo true > " .. widget_dir .. "airplane_mode" .. [[
]]


local toggle_action = function()
	if ap_state then
		awful.spawn.easy_async_with_shell(
			ap_off_cmd,
			function(stdout)
				ap_state = false
				update_imagebox()
			end
		)
	else
		awful.spawn.easy_async_with_shell(
			ap_on_cmd,
			function(stdout)
				ap_state = true
				update_imagebox()
			end
		)
	end
end

widget_button:buttons(
	gears.table.join(
		awful.button({}, 1, nil, function() toggle_action() end)
	)
)

gears.timer {
	timeout = 5,
	autostart = true,
	callback = function() check_airplane_mode_state() end
}

local action_widget =  wibox.widget {
	widget = wibox.container.margin,
	left = dpi(24),
	right = dpi(24),
	forced_height = dpi(48),
	{
		layout = wibox.layout.align.horizontal,
		action_name,
		nil,
		{
			layout = wibox.layout.fixed.horizontal,
			widget_button,
		}
	}
}

return action_widget
