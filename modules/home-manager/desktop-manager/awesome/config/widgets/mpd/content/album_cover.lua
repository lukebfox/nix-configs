local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')

local icons = require('icons')

local album_cover_img = wibox.widget {
  layout = wibox.layout.fixed.vertical,
  {
    widget = wibox.widget.imagebox,
    id = 'cover',
    image = icons.vinyl,
    resize = true,
    clip_shape = gears.shape.rounded_rect
  }
}

return album_cover_img
