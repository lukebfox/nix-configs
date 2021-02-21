{ config, lib, pkgs, ... }:
let
    inherit (config.home) homeDirectory;
    inherit (config.xdg.userDirs) documents download pictures videos;
    inherit (config.modules.desktop.awesome.defaultPrograms.files) exec;
    inherit (pkgs) writeText;

in writeText "awesome-widgets-xdg_folders" ''
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local separator = wibox.widget {
	widget = wibox.widget.separator,
	orientation = 'horizontal',
	forced_height = dpi(1),
	forced_width = dpi(1),
	span_ratio = 0.55
}

local create_bookmark_widget = function(text, icon, dir)

	local bookmark = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(10),
			{
				layout = wibox.layout.align.horizontal,
				{
					widget = wibox.widget.imagebox,
					image = icon,
					resize = true
				}
			}
		}
	}

	bookmark:buttons(
		gears.table.join(
			awful.button({}, 1, nil, function() awful.spawn.with_shell('${exec} '.. dir) end)
		)
	)

	awful.tooltip(
		{
			objects = {bookmark},
			mode = 'outside',
			align = 'right',
			text = text,
			margin_leftright = dpi(8),
			margin_topbottom = dpi(8),
			preferred_positions = {'top', 'bottom', 'right', 'left'}
		}
	)

	return bookmark
end

local create_xdg_widgets = function()
	return wibox.widget {
		layout = wibox.layout.align.vertical,
	  	{
			layout = wibox.layout.fixed.vertical,
			separator,
			create_bookmark_widget('Home',      icons.folder_home,      '${homeDirectory}'),
			create_bookmark_widget('Documents', icons.folder_documents, '${documents}'),
			create_bookmark_widget('Download',  icons.folder_downloads, '${download}'),
			create_bookmark_widget('Pictures',  icons.folder_pictures,  '${pictures}'),
			create_bookmark_widget('Videos',    icons.folder_videos,    '${videos}'),
	  	}
	}
end

return create_xdg_widgets
''
