local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local notif_header = wibox.widget {
	widget = wibox.widget.textbox,
	text   = 'Notification Center',
	font   = 'Inter Bold 16', --TODO font
	align  = 'left',
	valign = 'bottom'
}

local notif_center = function(s)

	s.dont_disturb    = require('widgets.notif_center.dont_disturb')
	s.clear_all       = require('widgets.notif_center.clear_all')
	s.notifbox_layout = require('widgets.notif_center.build_notifbox').notifbox_layout

	return wibox.widget {
		layout = wibox.layout.fixed.vertical,
		expand = 'none',
		spacing = dpi(10),
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			notif_header,
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
				s.dont_disturb,
				s.clear_all
			}
		},
		s.notifbox_layout
	}
end

return notif_center
