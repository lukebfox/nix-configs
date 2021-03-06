local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local clickable_container = require('widgets.clickable_container_effectful')

local layout_box = function(s)
	local layoutbox = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(7),
			awful.widget.layoutbox(s)
		}
	}

	layoutbox:buttons(
		awful.util.table.join(
			awful.button({}, 1,	function() awful.layout.inc(1)  end),
			awful.button({}, 3,	function() awful.layout.inc(-1)	end),
			awful.button({}, 4,	function() awful.layout.inc(1)	end),
			awful.button({}, 5,	function() awful.layout.inc(-1)	end)
		)
	)
	return layoutbox
end

return layout_box
