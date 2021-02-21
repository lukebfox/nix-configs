local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local decorate_widget = function(widgets)

	return wibox.widget {
		widget = wibox.container.background,
		bg = beautiful.groups_bg,
		shape = beautiful.groups_shape_rounded_rectangle,
		widgets
	}

end

local build_social_button = function(website)

	local social_imgbox = wibox.widget {
		layout = wibox.layout.align.horizontal,
		{
			widget = wibox.widget.imagebox,
			id = 'icon',
			image = icons.website,
			resize = true,
			forced_height = dpi(35)
		}
	}

	local social_button = wibox.widget {
		widget = clickable_container,
		{
			widget = wibox.container.margin,
			margins = dpi(7),
			social_imgbox
		}
	}

	local website_url = nil
	if website == 'hackernews' then
		website_url = 'https://news.ycombinator.com/'

	--elseif website == 'reddit' then
	--	website_url = 'https://reddit.com'

	--elseif website == 'twitter' then
	--	website_url = 'https://twitter.com'

	--elseif website == 'linkedin' then
	--	website_url = 'https://linkedin.com'

	end

	social_button:buttons(
		gears.table.join(
			awful.button({}, 1, nil, function()	awful.spawn({'xdg-open', website_url}, false) end)
		)
	)

	local social_name = website:sub(1,1):upper() .. website:sub(2)

	local social_tbox = wibox.widget {
		widget = wibox.widget.textbox,
		text = social_name,
		font = beautiful.font,
		align = 'center',
		valign = 'center'
	}

	return wibox.widget {
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(5),
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			nil,
			decorate_widget(social_button),
			nil
		},
		social_tbox
	}
end


local social_layout = wibox.widget {
	layout = wibox.layout.fixed.horizontal,
	spacing = dpi(5),
	build_social_button('hackernews'),
}

local social = wibox.widget {
	widget = wibox.container.background,
	forced_height = dpi(92),
	bg = beautiful.groups_bg,
	shape = beautiful.groups_shape_rounded_rectangle,
	{
		widget = wibox.container.margin,
		margins = dpi(10),
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			nil,
			social_layout,
			nil
		}
	}
}

return social
