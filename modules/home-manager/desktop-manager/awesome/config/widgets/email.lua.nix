{ config, lib, pkgs, ... }:
let
	inherit (config.modules.desktop-manager.awesome.widgets.email)
		emailAddress
		emailAppPassword
		imapServer
		port;

	inherit (pkgs) writers writeText;

	fetch_mail = writers.writePython3 "fetch_mail.py" {} ''
import imaplib
import email
import datetime
import re
from email.policy import default


def process_mailbox(M):
    rv, data = M.search(None, "(UNSEEN)")
    if rv != 'OK':
        print("No messages found!")
        return

    for num in reversed(data[0].split()):
        rv, data = M.fetch(num, '(BODY.PEEK[])')
        if rv != 'OK':
            print("ERROR getting message", num)
            return

        msg = email.message_from_bytes(data[0][1], policy=default)
        print('From:', msg['From'])
        print('Subject: %s' % (msg['Subject']))
        date_tuple = email.utils.parsedate_tz(msg['Date'])
        if date_tuple:
            local_date = datetime.datetime.fromtimestamp(
              email.utils.mktime_tz(date_tuple)
            )
            print(
              "Local Date:",
              local_date.strftime("%a, %H:%M:%S %b %d, %Y") + "\n"
            )


try:
    M = imaplib.IMAP4_SSL("${imapServer}", ${port})
    M.login("${emailAddress}", "${emailAppPassword}")

    status, counts = M.status("INBOX", "(MESSAGES UNSEEN)")

    rv, data = M.select("INBOX")
    if rv == 'OK':
        unread = re.search(
            r'UNSEEN\s(\d+)',
            counts[0].decode('utf-8')
        ).group(1)
        print("Unread Count: " + unread)
        process_mailbox(M)

        M.close()
        M.logout()

except Exception as e:
    if e:
        print(e)
  '';

in writeText "awesome-widgets-email" ''
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons = require('icons')

local unread_email_count = 0
local startup_show = true

local scroll_container = function(widget)
    return wibox.widget {
        layout = wibox.container.scroll.horizontal,
        id = 'scroll_container',
        max_size = 345,
        speed = 75,
        expand = true,
        direction = 'h',
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        fps = 30,
        widget
    }
end

local email_icon_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    {
        widget = wibox.widget.imagebox,
        id = 'icon',
        image = icons.email,
        resize = true,
        forced_height = dpi(45),
        forced_width = dpi(45)
    }
}

local email_from_text = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = 'From:',
    align = 'left',
    valign = 'center'
}

local email_recent_from = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = 'loading@stdout.sh',
    align = 'left',
    valign = 'center'
}

local email_subject_text = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = 'Subject:',
    align = 'left',
    valign = 'center'
}

local email_recent_subject = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = 'Loading data',
    align = 'left',
    valign = 'center'
}

local email_date_text = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = 'Local Date:',
    align = 'left',
    valign = 'center'
}

local email_recent_date = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font,
    markup = 'Loading date...',
    align = 'left',
    valign = 'center'
}

local email_report = wibox.widget{
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
                email_icon_widget,
                nil
            },
            {
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                {
                    layout = wibox.layout.fixed.vertical,
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = dpi(5),
                        email_from_text,
                        scroll_container(email_recent_from)
                    },
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = dpi(5),
                        email_subject_text,
                        scroll_container(email_recent_subject)
                    },
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = dpi(5),
                        email_date_text,
                        scroll_container(email_recent_date)
                    }
                },
                nil
            }
        }
    }
}

local email_details_tooltip = awful.tooltip {
    text = 'Loading...',
    objects = {email_icon_widget},
    mode = 'outside',
    align = 'right',
    preferred_positions = {'left', 'right', 'top', 'bottom'},
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8)
}


local notify_all_unread_email = function(email_data)

    local unread_counter = email_data:match('Unread Count: (.-)From:'):sub(1, -2)
    local email_data = email_data:match('(From:.*)'):sub(1, -2)
    local title = nil

    if tonumber(unread_email_count) > 1 then
        title = 'You have ' .. unread_counter .. ' unread emails.'
    else
        title = 'You have ' .. unread_counter .. ' unread email.'
    end

    naughty.notification ({
            app_name = 'Email',
            title = title,
            message = email_data,
            timeout = 30,
            icon = icons.email_unread
    })
end

local notify_new_email = function(count, from, subject)
    if not startup_show and (tonumber(count) > tonumber(unread_email_count)) then
        unread_email_count = tonumber(count)

        local message = "From: " .. from ..
            "\nSubject: " .. subject

        naughty.notification ({
                app_name = 'Email',
                title = 'You have a new unread email!',
                message = message,
                timeout = 10,
                icon = icons.email_unread
        })
    else
        unread_email_count = tonumber(count)
    end

end

local set_email_data_tooltip = function(email_data)
    local email_data = email_data:match('(From:.*)')
    local counter = "<span font='" .. beautiful.font .. "'>Unread Count: </span>" .. unread_email_count
    email_details_tooltip:set_markup(counter .. '\n\n' .. email_data)
end

local set_widget_markup = function(from, subject, date, tooltip)

    email_recent_from:set_markup(from:gsub('%\n', ""))
    email_recent_subject:set_markup(subject:gsub('%\n', ""))
    email_recent_date:set_markup(date:gsub('%\n', ""))

    if tooltip then
        email_details_tooltip:set_markup(tooltip)
    end
end

local set_no_connection_msg = function()
    set_widget_markup(
        'message@stderr.sh',
        'Check network connection!',
        os.date('%d-%m-%Y %H:%M:%S'),
        'No internet connection!'
    )
end

local set_invalid_credentials_msg = function()
    set_widget_markup(
        'message@stderr.sh',
        'Invalid Credentials!',
        os.date('%d-%m-%Y %H:%M:%S'),
        'You have an invalid credentials!'
    )
end

local set_latest_email_data = function(email_data)

    local unread_count = email_data:match('Unread Count: (.-)From:'):sub(1, -2)
    local recent_from = email_data:match('From: (.-)Subject:'):sub(1, -2)
    local recent_subject = email_data:match('Subject: (.-)Local Date:'):sub(1, -2)
    local recent_date = email_data:match('Local Date: (.-)\n')

    recent_from = recent_from:match('<(.*)>') or recent_from:match('&lt;(.*)&gt;') or recent_from

    local count = tonumber(unread_count)
    if count > 0 and count <= 9 then
        email_icon_widget.icon:set_image(icons['email_'.. tostring(count)])
    elseif count > 9 then
        email_icon_widget.icon:set_image(icons.email_many)
    end

    set_widget_markup(
        recent_from,
        recent_subject,
        recent_date
    )

    notify_new_email(unread_count, recent_from, recent_subject)
end

local set_empty_inbox_msg = function()
    set_widget_markup(
        'empty@stdout.sh',
        'Empty inbox',
        os.date('%d-%m-%Y %H:%M:%S'),
        'Empty inbox.'
    )
end

local fetch_email_data = function()
    awful.spawn.easy_async_with_shell(
        "${fetch_mail}",
        function(stdout)
            stdout = gears.string.xml_escape(stdout:sub(1, -2))

            if stdout:match('Temporary failure in name resolution') then
                set_no_connection_msg()
                return
            elseif stdout:match('Invalid credentials') then
                set_invalid_credentials_msg()
                return
            elseif stdout:match('Unread Count: 0') then
                email_icon_widget.icon:set_image(icon.email)
                set_empty_inbox_msg()
                return
            elseif not stdout:match('Unread Count: (.-)From:') then
                return
            elseif not stdout or stdout == "" then
                return
            end

            set_latest_email_data(stdout)
            set_email_data_tooltip(stdout)

            if startup_show then
                notify_all_unread_email(stdout)
                startup_show = false
            end
        end
    )
end

fetch_email_data()

local update_widget_timer = gears.timer {
    timeout   = 30,
    autostart = true,
    call_now  = true,
    callback  = function() fetch_email_data() end
}

email_report:connect_signal('mouse::enter', function() fetch_email_data() end)

awesome.connect_signal('system::network_connected', function()
    gears.timer.start_new(5, function() fetch_email_data() end)
end)

return email_report
''
