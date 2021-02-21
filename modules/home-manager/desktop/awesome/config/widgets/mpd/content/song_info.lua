local beautiful = require("beautiful")
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi
local song_info = {}

song_info.music_title = wibox.widget {
  layout = wibox.layout.align.horizontal,
  expand = 'none',
  nil,
  {
    layout        = wibox.container.scroll.horizontal,
    id            = 'scroll_container',
    max_size      = 345,
    speed         = 75,
    expand        = true,
    direction     = 'h',
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    fps           = 60,
    {
      widget    = wibox.widget.textbox,
      id        = 'title',
      text      = 'The song title is here',
      font      = 'Inter Bold 12', --TODO font
      align     = 'center',
      valign    = 'center',
      ellipsize = 'end'
    }
  },
  nil
}

song_info.music_artist = wibox.widget {
  layout = wibox.layout.align.horizontal,
  expand = 'none',
  nil,
  {
    layout        = wibox.container.scroll.horizontal,
    id            = 'scroll_container',
    max_size      = 345,
    speed         = 75,
    expand        = true,
    direction     = 'h',
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    fps           = 60,
    {
      widget = wibox.widget.textbox,
      id     = 'artist',
      text   = 'The artist name is here',
      font   = beautiful.font,
      align  = 'center',
      valign = 'center'
    }
  },
  nil
}

song_info.music_info = wibox.widget {
  layout = wibox.layout.fixed.vertical,
  song_info.music_title,
  song_info.music_artist
}

return song_info
