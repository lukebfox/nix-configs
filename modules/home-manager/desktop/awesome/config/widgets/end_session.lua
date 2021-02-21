local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local create_widget = function()
	local exit_widget = {
		widget = wibox.container.margin,
		left = dpi(24),
		right = dpi(24),
		forced_height = dpi(48),
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(24),
			{
				widget = wibox.container.margin,
				top = dpi(12),
				bottom = dpi(12),
				{
					widget = wibox.widget.imagebox,
					image = icons.logout,
					resize = true
				}
			},
			{
				widget = wibox.widget.textbox,
				text = 'End work session',
				font = 'Fira Sans 12',  -- TODO theme var larger font size
				align = 'left',
				valign = 'center'
			}
		}
	}

	local exit_button = wibox.widget {
		widget = wibox.container.background,
		bg = beautiful.groups_bg,
		shape = beautiful.groups_shape_rounded_rectangle,
		{
			widget = clickable_container,
			exit_widget
		}
	}

	exit_button:buttons(
		awful.util.table.join(
			awful.button({}, 1,	nil, function()
				screen.primary.left_panel:toggle()
				awesome.emit_signal('component::exit_screen:show')
			end)
		)
	)

	return exit_button
end

return create_widget
