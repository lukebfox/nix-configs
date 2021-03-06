local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local builder       = require('widgets.notif_center.build_notifbox.notifbox_ui_elements')
local notifbox_core = require('widgets.notif_center.build_notifbox')

local notifbox_layout = notifbox_core.notifbox_layout
local remove_notifbox_empty = notifbox_core.remove_notifbox_empty
local reset_notifbox_layout = notifbox_core.reset_notifbox_layout

local return_date_time = function(format) return os.date(format) end

local parse_to_seconds = function(time)
	local hourInSec = tonumber(string.sub(time, 1, 2)) * 3600
	local minInSec = tonumber(string.sub(time, 4, 5)) * 60
	local getSec = tonumber(string.sub(time, 7, 8))
	return (hourInSec + minInSec + getSec)
end

notifbox_box = function(notif, icon, title, message, app, bgcolor)

	local time_of_pop = return_date_time('%H:%M:%S')
	local exact_time = return_date_time('%I:%M %p')
	local exact_date_time = return_date_time('%b %d, %I:%M %p')

	local notifbox_timepop =  wibox.widget {
		widget = wibox.widget.textbox,
		id = 'time_pop',
		markup = nil,
		font = beautiful.font,
		align = 'left',
		valign = 'center',
		visible = true
	}

	local notifbox_dismiss = builder.notifbox_dismiss()

	local time_of_popup = gears.timer {
		timeout   = 60,
		call_now  = true,
		autostart = true,
		callback  = function()

			local time_difference = nil

			time_difference = parse_to_seconds(return_date_time('%H:%M:%S')) - parse_to_seconds(time_of_pop)
			time_difference = tonumber(time_difference)

			if time_difference < 60 then
				notifbox_timepop:set_markup('now')

			elseif time_difference >= 60 and time_difference < 3600 then
				local time_in_minutes = math.floor(time_difference / 60)
				notifbox_timepop:set_markup(time_in_minutes .. 'm ago')

			elseif time_difference >= 3600 and time_difference < 86400 then
				notifbox_timepop:set_markup(exact_time)

			elseif time_difference >= 86400 then
				notifbox_timepop:set_markup(exact_date_time)
				return false

			end

			collectgarbage('collect')
		end
	}

	local notifbox_template =  wibox.widget {
		widget = wibox.container.background,
		id = 'notifbox_template',
		expand = 'none',
		bg = bgcolor,
		shape = beautiful.groups_shape_rounded_rectangle,
		{
			widget = wibox.container.margin,
			margins = dpi(10),
			{
				layout = wibox.layout.fixed.vertical,
				spacing = dpi(5),
				{
					layout = wibox.layout.align.horizontal,
					expand = 'none',
					{
						layout = wibox.layout.fixed.horizontal,
						spacing = dpi(5),
						builder.notifbox_icon(icon),
						builder.notifbox_appname(app)
					},
					nil,
					{
						layout = wibox.layout.fixed.horizontal,
						notifbox_timepop,
						notifbox_dismiss
					}
				},
				{
					layout = wibox.layout.fixed.vertical,
					spacing = dpi(5),
					{
						layout = wibox.layout.fixed.vertical,
						builder.notifbox_title(title),
						builder.notifbox_message(message),
					},
					builder.notifbox_actions(notif)
				}
			}
		}
	}

	-- Put the generated template to a container
	local notifbox = wibox.widget {
		widget = wibox.container.background,
		shape = beautiful.client_shape_rounded_rectangle,
		notifbox_template
	}

    -- Delete notifbox on LMB
    notifbox:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if #notifbox_layout.children == 1 then
                    reset_notifbox_layout()
                else
                    -- Delete notification box
                    notifbox_layout:remove_widgets(notifbox, true)
                end
                collectgarbage('collect')
		    end)
        )
    )

	-- Add hover, and mouse leave events
	notifbox_template:connect_signal('mouse::enter', function()
        notifbox.bg = beautiful.groups_bg
        notifbox_timepop.visible = false
        notifbox_dismiss.visible = true
    end)

	notifbox_template:connect_signal('mouse::leave', function()
        notifbox.bg = beautiful.tranparent
        notifbox_timepop.visible = true
        notifbox_dismiss.visible = false
    end)

	collectgarbage('collect')

	return notifbox
end

return notifbox_box
