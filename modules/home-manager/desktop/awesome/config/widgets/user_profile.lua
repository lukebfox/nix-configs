-- User profile widget
-- Optional dependency:
--    mugshot (use to update profile picture and information)

local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local apps                = require('configuration.apps')
local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local user_icon_dir = '/var/lib/AccountsService/icons/'

local profile_imagebox = wibox.widget {
	layout = wibox.layout.align.horizontal,
	{
		widget = wibox.widget.imagebox,
		id = 'icon',
		forced_height = dpi(45),
		forced_width = dpi(45),
		image = icons.default_user,
		resize = true,
		clip_shape = beautiful.groups_shape_rounded_rectangle
	}
}

profile_imagebox:buttons(
	gears.table.join(
		awful.button({}, 1, nil, function() awful.spawn.single_instance('mugshot') end)
	)
)

local profile_name = wibox.widget {
	widget = wibox.widget.textbox,
	font = beautiful.font,
	markup = 'User',
	align = 'left',
	valign = 'center'
}

local distro_name = wibox.widget {
	widget = wibox.widget.textbox,
	font = beautiful.font,
	markup = 'GNU/Linux',
	align = 'left',
	valign = 'center'
}

local kernel_version = wibox.widget {
	widget = wibox.widget.textbox,
	font = beautiful.font,
	markup = 'Linux',
	align = 'left',
	valign = 'center'
}

local uptime_time = wibox.widget {
	widget = wibox.widget.textbox,
	font = beautiful.font,
	markup = 'up 1 minute',
	align = 'left',
	valign = 'center'
}

local update_profile_image = function()
	awful.spawn.easy_async_with_shell(
		apps.utils.update_profile,
		function(stdout)
			stdout = stdout:gsub('%\n','')
			if not stdout:match('default') then
				profile_imagebox.icon:set_image(stdout)
			else
				profile_imagebox.icon:set_image(icons.default_user)
			end
		end
	)
end

update_profile_image()

awful.spawn.easy_async_with_shell(
	[[
	sh -c '
	fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
	if [ -z "$fullname" ];
	then
		printf "$(whoami)@$(hostname)"
	else
		printf "$fullname"
	fi
	'
	]],
	function(stdout)
		local stdout = stdout:gsub('%\n', '')
		profile_name:set_markup(stdout)
	end
)

awful.spawn.easy_async_with_shell(
	"cat /etc/os-release | awk 'NR==1'| awk -F '=' '{print $2}'",
	function(stdout)
		local distroname = stdout:gsub('%\n', '')
		distro_name:set_markup(distroname)
	end
)

awful.spawn.easy_async_with_shell(
	"uname -r",
	function(stdout)
		local kname = stdout:gsub('%\n', '')
		kernel_version:set_markup(kname)
	end
)

local update_uptime = function()
	awful.spawn.easy_async_with_shell(
		"uptime -p",
		function(stdout)
			local uptime = stdout:gsub('%\n','')
			uptime_time:set_markup(uptime)
		end
	)
end

local uptime_updater_timer = gears.timer{
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function() update_uptime() end
}

local user_profile = wibox.widget {
	widget = wibox.container.background,
	forced_height = dpi(92),
	bg = beautiful.groups_bg,
	shape = beautiful.groups_shape_rounded_rectangle,
	{
		widget = wibox.container.margin,
		margins = dpi(10),
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(10),
			{
				layout = wibox.layout.align.vertical,
				expand = 'none',
				nil,
				profile_imagebox,
				nil
			},
			{
				layout = wibox.layout.align.vertical,
				expand = 'none',
				nil,
				{
					layout = wibox.layout.fixed.vertical,
					profile_name,
					distro_name,
					kernel_version,
					uptime_time
				},
				nil
			}
		}
	}
}

user_profile:connect_signal('mouse::enter', function() update_uptime() end)

return user_profile
