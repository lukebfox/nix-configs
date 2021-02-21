local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local apps                = require('configuration.apps')
local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local msg_table = {
	'See you later, alligator!',
	'After a while, crocodile.',
	'I’m out of here.',
	'Peace out!',
	'Gotta get going.',
	'Don\'t forget to come back!',
	'In a while, crocodile.',
	'Adios, amigo.',
	'Begone!',
	'Never look back!',
	'Au revoir!',
	'Later, skater!',
	'Happy trails!',
	'Smell ya later!',
	'See you soon, baboon!',
	'Bye Luke!',
	'Sayonara!',
	'Ciao!',
	'Choose wisely!'
}

local greeter_message = wibox.widget {
	widget = wibox.widget.textbox,
	markup = 'Choose wisely!',
	font = 'Inter UltraLight 48', --TODO font
	align = 'center',
	valign = 'center'
}

local profile_name = wibox.widget {
	widget = wibox.widget.textbox,
	markup = 'user@hostname',
	font = 'Inter Bold 12', --TODO font
	align = 'center',
	valign = 'center'
}

local profile_imagebox = wibox.widget {
	widget = wibox.widget.imagebox,
	image = icons.default_user,
	resize = true,
	forced_height = dpi(140),
	clip_shape = gears.shape.circle
}

local update_profile_pic = function()
	awful.spawn.easy_async_with_shell(
		apps.utils.update_profile,
		function(stdout)
			stdout = stdout:gsub('%\n','')
			if not stdout:match('default') then
				profile_imagebox:set_image(stdout)
			else
				profile_imagebox:set_image(icons.default_user)
			end
			profile_imagebox:emit_signal('widget::redraw_needed')
		end
	)
end

update_profile_pic()

local update_user_name = function()
	awful.spawn.easy_async_with_shell(
		[[
		fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
		if [ -z "$fullname" ];
		then
				printf "$(whoami)@$(hostname)"
		else
			printf "$fullname"
		fi
		]],
		function(stdout)
			stdout = stdout:gsub('%\n','')
			local first_name = stdout:match('(.*)@') or stdout:match('(.-)%s')
			first_name = first_name:sub(1, 1):upper() .. first_name:sub(2)
			profile_name:set_markup(stdout)
			profile_name:emit_signal('widget::redraw_needed')
		end
	)
end

update_user_name()

local update_greeter_msg = function()
	greeter_message:set_markup(msg_table[math.random(#msg_table)])
	greeter_message:emit_signal('widget::redraw_needed')
end

update_greeter_msg()

local build_power_button = function(name, icon, callback)
	local power_button_label= wibox.widget {
		widget = wibox.widget.textbox,
		text   = name,
		font   = beautiful.font,
		align  = 'center',
		valign = 'center',
	}

	local power_button = wibox.widget {
		widget = wibox.container.margin,
		left   = dpi(24),
		right  = dpi(24),
		{
			widget        = clickable_container,
			shape         = gears.shape.rounded_rect,
			forced_width  = dpi(90),
			forced_height = dpi(90),
			{
				widget = wibox.container.background,
				bg     = beautiful.groups_bg,
				{
					widget  = wibox.container.margin,
					margins = dpi(16),
					{
						widget = wibox.widget.imagebox,
						image  = icon,
					}
				}
			}
		}
	}

	local exit_screen_item = wibox.widget {
		layout  = wibox.layout.fixed.vertical,
		spacing = dpi(5),
		power_button,
		power_button_label
	}

	exit_screen_item:connect_signal('button::release', function() callback() end)
	return exit_screen_item
end

local suspend_command = function()
	awesome.emit_signal('component::exit_screen:hide')
	awful.spawn.with_shell(apps.default.lock .. ' & systemctl suspend')
end

local logout_command = function()
	awesome.quit()
end

local lock_command = function()
	awesome.emit_signal('component::exit_screen:hide')
	awful.spawn.with_shell(apps.default.lock)
end

local poweroff_command = function()
	awful.spawn.with_shell('poweroff')
	awesome.emit_signal('component::exit_screen:hide')
end

local reboot_command = function()
	awful.spawn.with_shell('reboot')
	awesome.emit_signal('component::exit_screen:hide')
end

local poweroff = build_power_button('Shutdown', icons.power,       poweroff_command)
local reboot   = build_power_button('Restart',  icons.restart,     reboot_command)
local suspend  = build_power_button('Sleep',    icons.power_sleep, suspend_command)
local logout   = build_power_button('Logout',   icons.logout,      logout_command)
local lock     = build_power_button('Lock',     icons.lock,        lock_command)

local create_exit_screen = function(s)
	s.exit_screen = wibox
	{
		screen  = s,
		type    = 'splash',
		visible = false,
		ontop   = true,
		bg      = beautiful.background,
		fg      = beautiful.fg_normal,
		height  = s.geometry.height,
		width   = s.geometry.width,
		x       = s.geometry.x,
		y       = s.geometry.y
	}

	s.exit_screen:buttons(
		gears.table.join(
			awful.button({}, 2,	function() awesome.emit_signal('component::exit_screen:hide')	end),
			awful.button({}, 3,	function() awesome.emit_signal('component::exit_screen:hide')	end)
		)
	)

	s.exit_screen : setup {
		layout = wibox.layout.align.vertical,
		expand = 'none',
		nil,
		{
			layout = wibox.layout.align.vertical,
			{
				layout = wibox.layout.align.horizontal,
				expand = 'none',
				nil,
				{
					layout = wibox.layout.fixed.vertical,
					spacing = dpi(5),
					{
						layout = wibox.layout.align.vertical,
						expand = 'none',
						nil,
						{
							layout = wibox.layout.align.horizontal,
							expand = 'none',
							nil,
							profile_imagebox,
							nil,
						},
						nil,
					},
					profile_name,
				},
				nil,
			},
			{
				layout = wibox.layout.align.horizontal,
				expand = 'none',
				nil,
				{
					widget = wibox.container.margin,
					margins = dpi(15),
					greeter_message,
				},
				nil,
			},
			{
				layout = wibox.layout.align.horizontal,
				expand = 'none',
				nil,
				{
					widget  = wibox.container.margin,
					margins = dpi(15),
					{
						layout  = wibox.layout.fixed.vertical,
						spacing = dpi(30),
						{
							layout = wibox.layout.fixed.horizontal,
							poweroff,
							reboot,
							suspend,
							logout,
							lock,
						},
					},
				},
				nil,
			},
		},
		nil,
	}
end

screen.connect_signal('request::desktop_decoration', function(s) create_exit_screen(s) end)

screen.connect_signal('removed', function(s) create_exit_screen(s) end)

local exit_screen_grabber = awful.keygrabber {
	auto_start = true,
	stop_event = 'release',
	keypressed_callback = function(self, mod, key, command)
		if     key == 's' then suspend_command()
		elseif key == 'e' then logout_command()
		elseif key == 'l' then lock_command()
		elseif key == 'p' then poweroff_command()
		elseif key == 'r' then reboot_command()
		elseif key == 'Escape' or key == 'q' or key == 'x' then
			awesome.emit_signal('component::exit_screen:hide')
		end
	end
}

awesome.connect_signal('component::exit_screen:show',function()
	for s in screen do
		s.exit_screen.visible = false
	end
	awful.screen.focused().exit_screen.visible = true
	exit_screen_grabber:start()
end)

awesome.connect_signal('component::exit_screen:hide', function()
    update_greeter_msg()
	exit_screen_grabber:stop()
	for s in screen do
		s.exit_screen.visible = false
	end
end)
