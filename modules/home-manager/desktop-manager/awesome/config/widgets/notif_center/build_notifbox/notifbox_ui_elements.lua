local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local ui_noti_builder = {}

-- Notification icon container
ui_noti_builder.notifbox_icon = function(ico_image)
    local noti_icon = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        {
            widget = wibox.widget.imagebox,
            id = 'icon',
            resize = true,
            forced_height = dpi(25),
            forced_width = dpi(25)
        },
    }
    noti_icon.icon:set_image(ico_image)
    return noti_icon
end

-- Notification title container
ui_noti_builder.notifbox_title = function(title)
    return wibox.widget {
        widget = wibox.widget.textbox,
        markup = title,
        font   = 'Inter Bold 12', --TODO font
        align  = 'left',
        valign = 'center'
    }
end

-- Notification message container
ui_noti_builder.notifbox_message = function(msg)
    return wibox.widget {
        widget = wibox.widget.textbox,
        markup = msg,
        font   = 'Inter Regular 11', --TODO font
        align  = 'left',
        valign = 'center'
    }
end

-- Notification app name container
ui_noti_builder.notifbox_appname = function(app)
    return wibox.widget {
        widget = wibox.widget.textbox,
        markup = app,
        font   = 'Inter Bold 12', --TODO font
        align  = 'left',
        valign = 'center'
    }
end

-- Notification actions container
ui_noti_builder.notifbox_actions = function(n)
    actions_template = wibox.widget {
        widget = naughty.list.actions,
        notification = n,
        base_layout = wibox.widget {
            layout  = wibox.layout.flex.horizontal,
            spacing = dpi(0)
        },
        widget_template = {
            widget  = wibox.container.margin,
            margins = 4,
            {
                widget        = wibox.container.background,
                bg            = beautiful.groups_bg,
                shape         = gears.shape.rounded_rect,
                forced_height = 30,
                {
                    widget = clickable_container,
                    {
                        widget = wibox.container.place,
                        {
                            widget = wibox.widget.textbox,
                            id     = 'text_role',
                            font   = beautiful.font
                        }
                    }
                }
            }
        },
        style = {
            underline_normal = false,
            underline_selected = true
        }
    }

    return actions_template
end


-- Notification dismiss button
ui_noti_builder.notifbox_dismiss = function()

    local dismiss_imagebox = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        {
            widget        = wibox.widget.imagebox,
            id            = 'dismiss_icon',
            image         = icons.delete,
            resize        = true,
            forced_height = dpi(5)
        }
    }

    local dismiss_button = wibox.widget {
        widget = clickable_container,
        {
            widget = wibox.container.margin,
            margins = dpi(5),
            dismiss_imagebox
        }
    }

    local notifbox_dismiss = wibox.widget {
        widget = wibox.container.background,
        bg = beautiful.groups_title_bg,
        shape = gears.shape.circle,
        visible = false,
        dismiss_button
    }

    return notifbox_dismiss
end


return ui_noti_builder
