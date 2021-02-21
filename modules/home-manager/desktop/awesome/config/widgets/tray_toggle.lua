local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local widget = wibox.widget {
	layout = wibox.layout.align.horizontal,
	{
		widget = wibox.widget.imagebox,
		id = 'icon',
		image = icons.right_arrow,
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
		awful.button({}, 1, nil, function()	awesome.emit_signal('widget::systray:toggle') end)
	)
)

-- Listen to signal
awesome.connect_signal('widget::systray:toggle', function()
   if screen.primary.systray then
		local icon
		if not screen.primary.systray.visible then
			icon = icons.left_arrow
		else
			icon = icons.right_arrow
		end
		widget.icon:set_image(gears.surface.load_uncached(icon))
		screen.primary.systray.visible = not screen.primary.systray.visible
	end
end)

-- Update icon on start-up
if screen.primary.systray then
	if screen.primary.systray.visible then
		widget.icon:set_image(icons.right_arrow)
	end
end

-- Show only the tray button in the primary screen
return awful.widget.only_on_screen(widget_button, 'primary')
