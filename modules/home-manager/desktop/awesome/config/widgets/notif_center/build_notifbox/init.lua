local awful     = require('awful')
local beautiful = require('beautiful')
local naughty   = require('naughty')
local wibox     = require('wibox')

local icons             = require('icons')
local empty_notifbox    = require('widgets.notif_center.build_notifbox.empty_notifbox')
local notifbox_scroller = require('widgets.notif_center.build_notifbox.notifbox_scroller')

local dpi = beautiful.xresources.apply_dpi
local notif_core = {}

notif_core.remove_notifbox_empty = true

notif_core.notifbox_layout = wibox.widget {
	layout = wibox.layout.fixed.vertical,
	spacing = dpi(7),
	empty_notifbox
}

notifbox_scroller(notif_core.notifbox_layout)

notif_core.reset_notifbox_layout = function()
	notif_core.notifbox_layout:reset()
	notif_core.notifbox_layout:insert(1, empty_notifbox)
	notif_core.remove_notifbox_empty = true
end

local notifbox_add = function(n, notif_icon, notifbox_color)
	if #notif_core.notifbox_layout.children == 1 and notif_core.remove_notifbox_empty then
		notif_core.notifbox_layout:reset(notif_core.notifbox_layout)
		notif_core.remove_notifbox_empty = false
	end
	local notifbox_box = require('widgets.notif_center.build_notifbox.notifbox_builder')
	notif_core.notifbox_layout:insert(
		1,
		notifbox_box(
			n,
			notif_icon,
			n.title,
			n.message,
			n.app_name,
			notifbox_color
		)
	)
end

local notifbox_add_expired = function(n, notif_icon, notifbox_color)
	n:connect_signal(
		'destroyed',
		function(self, reason, keep_visble)
			if reason == 1 then
				notifbox_add(n, notif_icon, notifbox_color)
			end
		end
	)
end

naughty.connect_signal(
	'request::display',
	function(n)
		local notifbox_color = beautiful.groups_bg
		if n.urgency == 'critical' then
			notifbox_color = n.bg .. '66'
		end

		local notif_icon = n.icon or n.app_icon
		if not notif_icon then
			notif_icon = icons.new_notif
		end

		notifbox_add_expired(n, notif_icon, notifbox_color)
	end
)

return notif_core
