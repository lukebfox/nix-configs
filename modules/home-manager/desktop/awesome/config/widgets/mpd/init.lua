local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')
--local music_box           = require('widgets.mpd.music_box')

--local toggle_music_box = music_box.toggle_music_box

local return_button = function()

	local widget_button = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(7),
			{
				layout = wibox.layout.align.horizontal,
				{
					widget = wibox.widget.imagebox,
					id = 'icon',
					image = icons.music,
					resize = true
				}
			}
		}
	}

	local music_tooltip =  awful.tooltip {
		objects = {widget_button},
		text = 'None',
		mode = 'outside',
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		align = 'right',
		preferred_positions = {'right', 'left', 'top', 'bottom'}
	}

	widget_button:buttons(
		gears.table.join(
			awful.button({}, 1, nil, function()
				music_tooltip.visible = false
				awesome.emit_signal('widget::music', 'mouse')
			end)
		)
	)

	widget_button:connect_signal("mouse::enter", function()
		awful.spawn.easy_async_with_shell('mpc status', function(stdout) music_tooltip.text = string.gsub(stdout, '\n$', '') end)
	end)

	return widget_button

end

return return_button
