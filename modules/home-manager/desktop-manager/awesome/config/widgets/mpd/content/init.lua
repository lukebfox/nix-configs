-- Return UI Table
return {
  album_cover   = require('widgets.mpd.content.album_cover'),
  progress_bar  = require('widgets.mpd.content.progress_bar'),
  track_time    = require('widgets.mpd.content.track_time'),
  song_info     = require('widgets.mpd.content.song_info'),
  media_buttons = require('widgets.mpd.content.media_buttons'),
  volume_slider = require('widgets.mpd.content.volume_slider'),
}
