local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi
local music_func = {}

screen.connect_signal(
  'request::desktop_decoration',
  function(s)

    -- Set music box geometry
    local music_box_margin = dpi(5)
    local music_box_height = dpi(375)
    local music_box_width = dpi(260)
    local music_box_x = nil


    s.musicpop = awful.popup {
      widget = {
        -- Removing this block will cause an error...
      },
      ontop = true,
      visible = false,
      type = 'dock',
      screen = s,
      width = music_box_width,
      height = music_box_height,
      maximum_width = music_box_width,
      maximum_height = music_box_height,
      offset = dpi(5),
      shape = gears.shape.rectangle,
      bg = beautiful.transparent,
      preferred_anchors = {'middle', 'back', 'front'},
      preferred_positions = {'left', 'right', 'top', 'bottom'},

    }

    local ui_content = require('widgets.mpd.content')

    s.album = ui_content.album_cover
    s.progress_bar = ui_content.progress_bar
    s.time_track = ui_content.track_time.time_track
    s.song_info = ui_content.song_info.music_info
    s.media_buttons = ui_content.media_buttons.navigate_buttons
    s.volume_slider  = ui_content.volume_slider.vol_slider

    s.musicpop : setup {
      widget = wibox.container.background(),
      bg = beautiful.background,
      shape = beautiful.groups_shape_rounded_rectangle,
      {
        widget = wibox.container.margin,
        top = dpi(15),
        left = dpi(15),
        right = dpi(15),
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(8),
          expand = 'none',
          {
            widget = wibox.container.margin,
            bottom = dpi(5),
            s.album,
          },
          {
            layout = wibox.layout.fixed.vertical,
            {
              layout = wibox.layout.fixed.vertical,
              spacing = dpi(4),
              s.progress_bar,
              s.time_track
            },
            s.song_info,
            s.media_buttons,
            s.volume_slider
          }
        }
      }
    }

    s.backdrop_music = wibox {
      ontop = true,
      visible = false,
      screen = s,
      type = 'utility',
      input_passthrough = false,
      bg = beautiful.transparent,
      x = s.geometry.x,
      y = s.geometry.y,
      width = s.geometry.width,
      height = s.geometry.height
    }

    local toggle_music_box = function(type)

      local focused = awful.screen.focused()
      local music_box = focused.musicpop
      local music_backdrop = focused.backdrop_music

      if music_box.visible then
        music_backdrop.visible = not music_backdrop.visible
        music_box.visible = not music_box.visible

      else

        if type == 'keyboard' then
          music_backdrop.visible = true
          music_box.visible = true
          awful.placement.top_right(
            music_box,
            {
              margins = {
                top = dpi(5),
                right = dpi(music_box_x or 5)
              },
              honor_workarea = true
          })
        else
          local widget_button = mouse.current_widget_geometry

          music_backdrop.visible = true
          music_box:move_next_to(widget_button)
          music_box_x = (focused.geometry.width - music_box.x) - music_box_width
        end
      end
    end

    awesome.connect_signal('widget::music', function(type) toggle_music_box(type) end)

    s.backdrop_music:buttons(
      awful.util.table.join(
        awful.button({}, 1, nil, function() toggle_music_box() end)
      )
    )
  end
)


music_func.toggle_music_box = toggle_music_box

local mpd_updater = require('widgets.mpd.mpd_music_updater')

return music_func
