{ config, pkgs, ... }:
let
    inherit (config.gtk) iconTheme;
    inherit (config.lib.base16) theme;
    inherit (pkgs) writeText;

in writeText "awesome-components-notifications" ''
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local menubar   = require('menubar')
local naughty   = require('naughty')
local ruled     = require('ruled')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local clickable_container = require('widgets.clickable_container_effectful')

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = 'System Notification'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
end

-- Apply theme variables
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_dirs = { '${iconTheme.package}/share/icons/${iconTheme.name}' }
naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }

-- Presets / rules
ruled.notification.connect_signal('request::rules', function()

    -- Critical notifs
    ruled.notification.append_rule {
        rule = { urgency = 'critical' },
        properties = {
            font = beautiful.font,
            bg = '#${theme.base08-hex}',
            fg = beautiful.fg_normal,
            margin = dpi(16),
            position = 'top_right',
            implicit_timeout = 0
        }
    }

    -- Normal notifs
    ruled.notification.append_rule {
        rule = { urgency = 'normal' },
        properties = {
            font = beautiful.font,
            bg = beautiful.transparent,
            fg = beautiful.fg_normal,
            margin = dpi(16),
            position = 'top_right',
            implicit_timeout = 5
        }
    }

    -- Low notifs
    ruled.notification.append_rule {
        rule = { urgency = 'low' },
        properties = {
            font = beautiful.font,
            bg = beautiful.transparent,
            fg = beautiful.fg_normal,
            margin = dpi(16),
            position = 'top_right',
            implicit_timeout = 5
        }
    }

end)


-- Error handling
naughty.connect_signal('request::display_error', function(message, startup)
    naughty.notification {
        urgency = 'critical',
        title   = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
        message = message,
        app_name = 'System Notification',
        icon = beautiful.awesome_icon
    }
end)

-- XDG icon lookup
naughty.connect_signal('request::icon', function(n, context, hints)
    if context ~= 'app_icon' then return end

    local path = menubar.utils.lookup_icon(hints.app_icon) or
        menubar.utils.lookup_icon(hints.app_icon:lower())

    if path then
        n.icon = path
    end
end)


-- Connect to naughty on display signal
naughty.connect_signal('request::display', function(n)

    -- Actions Blueprint
    local actions_template = wibox.widget {
        widget = naughty.list.actions,
        style = { underline_normal = false, underline_selected = true },
        notification = n,
        base_layout = wibox.widget {
            layout  = wibox.layout.flex.horizontal,
            spacing = dpi(0)
        },
        widget_template = {
            widget = wibox.container.margin,
            margins = dpi(4),
            {
                widget = wibox.container.background,
                bg = beautiful.groups_bg,
                forced_height = dpi(30),
                shape = gears.shape.rounded_rect,
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
        }
    }

    -- Notifbox Blueprint
    naughty.layout.box {
        notification = n,
        type = 'notification',
        screen = awful.screen.preferred(),
        shape = gears.shape.rectangle,
        widget_template = {
            widget = wibox.container.background,
            bg = beautiful.background,
            shape = gears.shape.rounded_rect,
            {
                widget = wibox.container.constraint,
                strategy = 'max',
                width = beautiful.notification_max_width or dpi(500),
                {
                    widget = wibox.container.constraint,
                    strategy = 'min',
                    width = dpi(160),
                    {
                        widget = naughty.container.background,
                        id = 'background_role',
                        bg = beautiful.transparent,
                        {
                            -- Actions
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(4),
                            {
                                bg = beautiful.transparent,
                                widget = wibox.container.background,
                                {
                                    -- Margin between the fake background
                                    -- Set to 0 to preserve the 'titlebar' effect
                                    margins = dpi(0),
                                    widget = wibox.container.margin,
                                    {
                                        layout = wibox.layout.fixed.vertical,
                                        fill_space = true,
                                        spacing = beautiful.notification_margin,
                                        {
                                            widget = wibox.container.background,
                                            bg = beautiful.background,
                                            {
                                                widget = wibox.container.margin,
                                                margins = beautiful.notification_margin,
                                                {
                                                    widget = wibox.widget.textbox,
                                                    markup = n.app_name or 'System Notification',
                                                    font = 'Inter Bold 10',
                                                    align = 'center',
                                                    valign = 'center'
                                                }
                                            }
                                        },
                                        {
                                            layout = wibox.layout.fixed.horizontal,
                                            {
                                                widget = wibox.container.margin,
                                                margins = beautiful.notification_margin,
                                                {
                                                    widget = naughty.widget.icon,
                                                    resize_strategy = 'center'
                                                }
                                            },
                                            {
                                                widget = wibox.container.margin,
                                                margins = beautiful.notification_margin,
                                                {
                                                    layout = wibox.layout.align.vertical,
                                                    expand = 'none',
                                                    nil,
                                                    {
                                                        layout = wibox.layout.fixed.vertical,
                                                        {
                                                            widget = naughty.widget.title,
                                                            align = 'left'
                                                        },
                                                        {
                                                            widget = naughty.widget.message,
                                                            align = 'left'
                                                        }
                                                    },
                                                    nil
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            actions_template
                        }
                    }
                }
            }
        }
    }

    -- Destroy popups if dont_disturb mode is on
    -- Or if the right_panel is visible
    local focused = awful.screen.focused()
    if _G.dont_disturb or
        (focused.right_panel and focused.right_panel.visible) then
        naughty.destroy_all_notifications(nil, 1)
    end

end)
''
