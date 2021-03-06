local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')

require('awful.autofocus')
awful.util.shell = 'sh'

beautiful.init(require('theme'))

require('layouts')
require('configuration.client.rules')
require('configuration.client.signals')
require('configuration.root')
require('configuration.tags')

root.keys(require('configuration.keys.global'))

require('components.notifications')
require('components.auto_start')
require('components.exit_screen')
require('components.quake_terminal')
require('components.menu')
require('components.titlebar')
require('components.brightness_osd')
require('components.volume_osd')
require('components.lockscreen')
require('components.dynamic_wallpaper')

screen.connect_signal('request::wallpaper', function(s)
  -- If wallpaper is a function, call it with the screen
  if beautiful.wallpaper then
    if type(beautiful.wallpaper) == 'string' then
      -- Check if beautiful.wallpaper is colour/image
      if beautiful.wallpaper:sub(1, #'#') == '#' then
        -- If beautiful.wallpaper is colour
        gears.wallpaper.set(beautiful.wallpaper)
      elseif beautiful.wallpaper:sub(1, #'/') == '/' then
        -- If beautiful.wallpaper is path/image
        gears.wallpaper.maximized(beautiful.wallpaper, s)
      end
    else
      beautiful.wallpaper(s)
    end
  end
end)
