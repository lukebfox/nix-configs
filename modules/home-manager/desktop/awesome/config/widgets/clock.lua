local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local clickable_container = require('widgets.clickable_container_effectful')

local create_clock = function(s)

	local clock_format = '<span font="' ..
		beautiful.font_bold .. '">%I:%M %p</span>'

	s.clock_widget = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(7),
	        wibox.widget.textclock(clock_format, 1)
		}
	}

	s.clock_widget:connect_signal('mouse::enter', function()
        local w = mouse.current_wibox
		if w then
			old_cursor, old_wibox = w.cursor, w
			w.cursor = 'hand1'
		end
	end)

	s.clock_widget:connect_signal('mouse::leave', function()
        if old_wibox then
			old_wibox.cursor = old_cursor
			old_wibox = nil
		end
	end)

	s.clock_tooltip = awful.tooltip
	{
		objects = {s.clock_widget},
		mode = 'outside',
		delay_show = 1,
		preferred_positions = {'right', 'left', 'top', 'bottom'},
		preferred_alignments = {'middle', 'front', 'back'},
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		timer_function = function()
			local ordinal = nil

			local day = os.date('%d')
			local month = os.date('%B')

			local first_digit = string.sub(day, 0, 1)
			local last_digit = string.sub(day, -1)

			if first_digit == '0' then
				day = last_digit
			end

			if last_digit == '1' and day ~= '11' then
				ordinal = 'st'
			elseif last_digit == '2' and day ~= '12' then
				ordinal = 'nd'
			elseif last_digit == '3' and day ~= '13' then
				ordinal = 'rd'
			else
				ordinal = 'th'
			end

			local date_str = 'Today is the ' .. '<b>' ..
				day .. ordinal .. ' of ' .. month ..
				'</b>,\n and it\'s a ' .. os.date('%A') ..
				'... Carpe diem.'

			return date_str
		end,
	}

    -- Hide the tooltip when you press the clock widget
	s.clock_widget:connect_signal('button::press', function(self, lx, ly, button)
		if s.clock_tooltip.visible and button == 1 then
			s.clock_tooltip.visible = false
		end
	end)

	s.month_calendar = awful.widget.calendar_popup.month({
		start_sunday  = true,
		spacing       = dpi(5),
		font          = beautiful.font,
		long_weekdays = true,
		margin        = dpi(5),
		screen        = s,
		style_month   = {
			border_width = dpi(0),
			bg_color 	 = beautiful.background,
			padding      = dpi(20),
			shape        = beautiful.groups_shape_rounded_rectangle
		},
		style_header = {
			border_width = 0,
			bg_color     = beautiful.transparent
		},
		style_weekday = {
			border_width = 0,
			bg_color     = beautiful.transparent
		},
		style_normal = {
			border_width = 0,
			bg_color     = beautiful.transparent
		},
		style_focus = {
			border_width = dpi(0),
			border_color = beautiful.fg_normal,
			bg_color     = beautiful.accent,
			shape        = beautiful.client_shape_rounded_rectangle
		},
	})

	s.month_calendar:attach(s.clock_widget, 'tc', {	on_pressed = true, on_hover = false	})

	return s.clock_widget
end

return create_clock
