local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = beautiful.xresources.apply_dpi
awful.titlebar.enable_tooltip = true
awful.titlebar.fallback_name  = 'Client'


local double_click_event_handler = function(double_click_event)
    if double_click_timer then
        double_click_timer:stop()
        double_click_timer = nil
        double_click_event()
        return
    end
    double_click_timer = gears.timer.start_new(0.20, function()
        double_click_timer = nil
        return false
    end)
end


local create_click_events = function(c)
    -- Titlebar button/click events
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            double_click_event_handler(function()
                if c.floating then
                    c.floating = false
                    return
                end
                c.maximized = not c.maximized
                c:raise()
                return
            end)
            c:activate {context = 'titlebar', action = 'mouse_move'}
        end),
        awful.button({}, 3, function()
            c:activate {context = 'titlebar', action = 'mouse_resize'}
        end)
    )
    return buttons
end


local create_vertical_bar = function(c, pos, bg, size)
    awful.titlebar(c, {position = pos, bg = bg, size = size}) : setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        {
            buttons = create_click_events(c),
            layout = wibox.layout.flex.vertical
        },
        {
            {
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.vertical
                                                                      }
end


local create_horizontal_bar = function(c, pos, bg, size)
    awful.titlebar(c, {position = pos, bg = bg, size = size}) : setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        {
            buttons = create_click_events(c),
            layout = wibox.layout.flex.horizontal
        },
        {
            {
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.horizontal
                                                                      }
end


local create_vertical_bar_dialog = function(c, pos, bg, size)
    awful.titlebar(c, {position = pos, bg = bg, size = size}) : setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.ontopbutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        {
            buttons = create_click_events(c),
            layout = wibox.layout.flex.vertical
        },
        nil,
        layout = wibox.layout.align.vertical
                                                                      }
end


local create_horizontal_bar_dialog = function(c, pos, bg, size)
    awful.titlebar(c, {position = pos, bg = bg, size = size}) : setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        {
            buttons = create_click_events(c),
            layout = wibox.layout.flex.horizontal
        },
        nil,
        layout = wibox.layout.align.horizontal
                                                                      }
end


client.connect_signal('request::titlebars', function(c)

    -- Nomal titlebars
    if c.type == 'normal' then

        if c.class == 'nautilus' then
            create_vertical_bar(c, 'left', '#000000AA', beautiful.titlebar_size)
        elseif c.class == 'Firefox' then
            create_vertical_bar(c, 'left', beautiful.background, beautiful.titlebar_size)
        elseif c.instance == 'transmission-qt' then
            create_vertical_bar(c, 'left', '#000000AA', beautiful.titlebar_size)
        elseif c.instance == 'nicotine-plus' then
            create_vertical_bar(c, 'top', '#000000AA', beautiful.titlebar_size)
        elseif c.class == 'Gimp-2.10' or c.class == 'Inkscape' then
            create_vertical_bar(c, 'left', '#000000AA', beautiful.titlebar_size)
        elseif c.class == 'element-desktop' then
            create_vertical_bar(c, 'left', '#17212b', beautiful.titlebar_size)
        else
            create_vertical_bar(c, 'left', beautiful.background, beautiful.titlebar_size)
        end

    -- Dialog titlebars
    elseif c.type == 'dialog' then
        if c.role == 'GtkFileChooserDialog' then
            create_vertical_bar_dialog(c, 'left', '#666666', beautiful.titlebar_size)
        elseif c.class == 'Gimp-2.10' then
            create_vertical_bar(c, 'left','#666666', beautiful.titlebar_size)
        else
            create_vertical_bar_dialog(c, 'left', '#000000AA', beautiful.titlebar_size)
        end

    -- Modal titlebars
    elseif c.type == 'modal' then
        create_vertical_bar(c, 'left', '#000000AA', beautiful.titlebar_size)

    -- Fallback titlebars
    else
        create_vertical_bar(c, 'left', beautiful.background, beautiful.titlebar_size)
    end

end)
