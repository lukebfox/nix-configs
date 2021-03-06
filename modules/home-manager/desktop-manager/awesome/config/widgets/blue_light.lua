local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi   = beautiful.xresources.apply_dpi

local clickable_container = require('widgets.clickable_container')
local icons               = require('icons')

local blue_light_state = nil

local action_name = wibox.widget {
	widget = wibox.widget.textbox,
	text = 'Blue Light',
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
		top = dpi(7),
		bottom = dpi(7),
		button_widget,
	}
}

local update_imagebox = function()
	local button_icon = button_widget.icon
	if blue_light_state then
		button_icon:set_image(icons.toggled_on)
	else
		button_icon:set_image(icons.toggled_off)
	end
end

local kill_state = function()
	awful.spawn.easy_async_with_shell(
		[[
		redshift -x
		kill -9 $(pgrep redshift)
		]],
		function(stdout)
			stdout = tonumber(stdout)
			if stdout then
				blue_light_state = false
				update_imagebox()
			end
		end
	)
end

kill_state()

local toggle_action = function()
	awful.spawn.easy_async_with_shell(
		[[
		if [ ! -z $(pgrep redshift) ];
		then
			redshift -x && pkill redshift && killall redshift
			echo 'OFF'
		else
			redshift -l 0:0 -t 4500:4500 -r &>/dev/null &
			echo 'ON'
		fi
		]],
		function(stdout)
			if stdout:match('ON') then
				blue_light_state = true
			else
				blue_light_state = false
			end
			update_imagebox()
		end
	)

end

widget_button:buttons(
	gears.table.join(
		awful.button({}, 1, nil, function() toggle_action() end)
	)
)

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
		},
	},
}

awesome.connect_signal('widget::blue_light:toggle',	function() toggle_action() end)

return action_widget
