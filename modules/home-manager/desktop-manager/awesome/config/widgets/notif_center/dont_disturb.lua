local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local dpi = beautiful.xresources.apply_dpi
local widget_dir = gears.filesystem.get_configuration_dir() .. 'widgets/notif_center'

_G.dont_disturb = false

local dont_disturb_imagebox = wibox.widget {
	layout = wibox.layout.fixed.horizontal,
	{
		widget = wibox.widget.imagebox,
		id = 'icon',
		image = icons.dont_disturb_mode,
		resize = true,
		forced_height = dpi(20),
		forced_width = dpi(20)
	}
}

local function update_icon()
	local dd_icon = dont_disturb_imagebox.icon
	if dont_disturb then
		dd_icon:set_image(icons.dont_disturb_mode)
	else
		dd_icon:set_image(icons.notify_mode)
	end
end

local check_disturb_status = function()

	awful.spawn.easy_async_with_shell(
		'cat ' .. widget_dir .. 'disturb_status',
		function(stdout)

			local status = stdout
			if status:match('true') then
				dont_disturb = true
			elseif status:match('false') then
				dont_disturb = false
			else
				dont_disturb = false
				awful.spawn.with_shell('echo "false" > ' .. widget_dir .. 'disturb_status')
			end

			update_icon()
		end
	)
end

check_disturb_status()

local toggle_disturb = function()
	if dont_disturb then
		dont_disturb = false
	else
		dont_disturb = true
	end
	awful.spawn.with_shell('echo "' .. tostring(dont_disturb) .. '" > ' .. widget_dir .. 'disturb_status')
	update_icon()
end

local dont_disturb_button = wibox.widget {
	widget = clickable_container,
	{
		widget = wibox.container.margin,
		margins = dpi(7),
		dont_disturb_imagebox
	}
}

dont_disturb_button:buttons(
	gears.table.join(
		awful.button({}, 1, nil, function()	toggle_disturb() end)
	)
)

local dont_disturb_wrapped = wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = 'none',
	nil,
	{
		widget = wibox.container.background,
		bg = beautiful.groups_bg,
		shape = gears.shape.circle,
		dont_disturb_button
	},
	nil
}

-- Create a notification sound
naughty.connect_signal('request::display', function(n)
	if dont_disturb or n.app_name == "Spotify" then return end

	awful.spawn.with_shell('canberra-gtk-play -i message')
end)

return dont_disturb_wrapped
