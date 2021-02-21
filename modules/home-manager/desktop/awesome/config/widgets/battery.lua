local awful   = require('awful')
local gears   = require('gears')
local naughty = require('naughty')
local wibox   = require('wibox')

local watch = awful.widget.watch

local apps                = require('configuration.apps')
local icons               = require("icons")
local dpi                 = require('beautiful').xresources.apply_dpi
local clickable_container = require('widgets.clickable_container_effectful')

local return_button = function()

	local battery_imagebox = wibox.widget {
		layout = wibox.layout.align.vertical,
		expand = 'none',
		nil,
		{
			widget = wibox.widget.imagebox,
			id = 'icon',
			image = icons.battery,
			resize = true
		},
		nil
	}

	local battery_percentage_text = wibox.widget {
		widget = wibox.widget.textbox,
		id = 'percent_text',
		text = '100%',
		font = 'Inter Bold 11', --TODO font
		align = 'center',
		valign = 'center',
		visible = false
	}

	local battery_widget = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(0),
		battery_imagebox,
		battery_percentage_text
	}

	local battery_button = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(7),
			battery_widget
		}
	}

	battery_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function() awful.spawn(apps.default.power_manager, false) end
			)
		)
	)

	local battery_tooltip =  awful.tooltip {
		objects = {battery_button},
		text = 'None',
		mode = 'outside',
		align = 'right',
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		preferred_positions = {'right', 'left', 'top', 'bottom'}
	}

	local get_battery_info = function()
		awful.spawn.easy_async_with_shell(
			'upower -i $(upower -e | grep BAT)',
			function(stdout)
				if stdout == nil or stdout == '' then
					battery_tooltip:set_text('No battery detected!')
					return
				end

				-- Remove new line from the last line
				battery_tooltip:set_text(stdout:sub(1, -2))
			end
		)
	end
	get_battery_info()

	battery_widget:connect_signal('mouse::enter', function() get_battery_info() end)

	local last_battery_check = os.time()
	local notify_critical_battery = true

    local show_battery_warning = function()
        naughty.notification ({
            icon = icons.battery-alert,
            app_name = 'System notification',
            title = 'Battery is dying!',
            message = 'Hey, I think we have a problem here. Save your work before reaching the oblivion.',
            urgency = 'critical'
        })
    end

	local update_battery = function(status)

		awful.spawn.easy_async_with_shell(
			[[sh -c "
			upower -i $(upower -e | grep BAT) | grep percentage | awk '{print \$2}' | tr -d '\n%'
			"]],
			function(stdout)
				local battery_percentage = tonumber(stdout)

				-- Stop if null
				if not battery_percentage then return end

				battery_widget.spacing = dpi(5)
				battery_percentage_text.visible = true
				battery_percentage_text:set_text(battery_percentage .. '%')

				-- Fully charged
				if (status == 'fully-charged' or status == 'charging') and battery_percentage == 100 then
					battery_imagebox.icon:set_image(gears.surface.load_uncached(icons.battery_fully_charged))
					return
				end

				-- Critical level warning message
				if (battery_percentage > 0 and battery_percentage < 10) and status == 'discharging' then

					if os.difftime(os.time(), last_battery_check) > 300 or notify_critical_battery then
						last_battery_check = os.time()
						notify_critical_battery = false
						show_battery_warning()
					end
					battery_imagebox.icon:set_image(gears.surface.load_uncached(icons.battery_alert_red))
					return
				end

				local icon

				if battery_percentage > 0 and battery_percentage < 20 then
					icon = icons["battery_"..status.."_10"]
				elseif battery_percentage >= 20 and battery_percentage < 30 then
					icon = icons["battery_"..status.."_20"]
				elseif battery_percentage >= 30 and battery_percentage < 50 then
					icon = icons["battery_"..status.."_30"]
				elseif battery_percentage >= 50 and battery_percentage < 60 then
					icon = icons["battery_"..status.."_50"]
				elseif battery_percentage >= 60 and battery_percentage < 80 then
					icon = icons["battery_"..status.."_60"]
				elseif battery_percentage >= 80 and battery_percentage < 90 then
					icon = icons["battery_"..status.."_80"]
				elseif battery_percentage >= 90 and battery_percentage < 100 then
					icon = icons["battery_"..status.."_90"]
				end

				battery_imagebox.icon:set_image(gears.surface.load_uncached(icon))
			end
		)
	end

	-- Watch status if charging, discharging, fully-charged
	watch(
		[[sh -c "
		upower -i $(upower -e | grep BAT) | grep state | awk '{print \$2}' | tr -d '\n'
		"]],
		5,
		function(widget, stdout)
			local status = stdout:gsub('%\n', '')

			-- If no output or no battery detected
			if status == nil or status == '' then
				battery_widget.spacing = dpi(0)
				battery_percentage_text.visible = false
				battery_tooltip:set_text('No battery detected!')
				battery_imagebox.icon:set_image(gears.surface.load_uncached(icons.battery_unknown))
				return
			end

			update_battery(status)
		end
	)

	return battery_button
end

return return_button
