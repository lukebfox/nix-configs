local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local clickable_container = require('widgets.clickable_container_effectful')

local media_buttons = {}

media_buttons.play_button_image = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'play',
    image = icons.play,
    resize = true
  }
}

media_buttons.next_button_image = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'next',
    image = icons.next,
    resize = true
  }
}

media_buttons.prev_button_image = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'prev',
    image = icons.prev,
    resize = true
  }
}

media_buttons.repeat_button_image = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'rep',
    image = icons.repeat_on,
    resize = true
  }
}

media_buttons.random_button_image = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'rand',
    image = icons.random_on,
    resize = true
  }
}

media_buttons.play_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(7),
    media_buttons.play_button_image
  }
}

media_buttons.next_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(10),
    media_buttons.next_button_image
  }
}

media_buttons.prev_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(10),
    media_buttons.prev_button_image
  }
}

media_buttons.repeat_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(10),
    media_buttons.repeat_button_image
  }
}

media_buttons.random_button = wibox.widget {
  widget = clickable_container,
  {
    widget = wibox.container.margin,
    margins = dpi(10),
    media_buttons.random_button_image
  }
}

media_buttons.navigate_buttons = wibox.widget {
  layout = wibox.layout.align.horizontal,
  expand = 'none',
  forced_height = dpi(35),
  media_buttons.repeat_button,
  {
    layout = wibox.layout.fixed.horizontal,
    forced_height = dpi(35),
    media_buttons.prev_button,
    media_buttons.play_button,
    media_buttons.next_button
  },
  media_buttons.random_button
}

return media_buttons
