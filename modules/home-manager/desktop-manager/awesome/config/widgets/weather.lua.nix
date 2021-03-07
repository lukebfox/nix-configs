{ config, pkgs, ... }:
let
  inherit (config.modules.desktop-manager.awesome.widgets.weather)
    apiToken
    cityId
    refreshInterval;

in pkgs.writeText "awesome-widgets-weather" ''
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears')
local naughty   = require('naughty')
local wibox     = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local icons               = require('icons')
local json                = require('lib.json')
local clickable_container = require('widgets.clickable_container_effectful')

local weather_icon_widget = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'icon',
    image = icons.weather_error,
    resize = true,
    forced_height = dpi(45),
    forced_width = dpi(45)
  }
}

local sunrise_icon_widget = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'sunrise_icon',
    image = icons.sunrise,
    resize = true,
    forced_height = dpi(18),
    forced_width = dpi(18)
  }
}

local sunset_icon_widget = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'sunset_icon',
    image = icons.sunset,
    resize = true,
    forced_height = dpi(18),
    forced_width = dpi(18)
  }
}

local refresh_icon_widget = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    widget = wibox.widget.imagebox,
    id = 'refresh_icon',
    image = icons.refresh,
    resize = true,
    forced_height = dpi(18),
    forced_width = dpi(18)
  }
}

local refresh_button = clickable_container(refresh_icon_widget)
refresh_button:buttons(
  gears.table.join(
    awful.button({}, 1, nil, function()
      awesome.emit_signal('widget::weather_fetch')
      awesome.emit_signal('widget::forecast_fetch')
    end)
  )
)

local refresh_widget = wibox.widget {
  widget = wibox.container.background,
  bg = beautiful.transparent,
  shape = gears.shape.circle,
  refresh_button
}

local weather_desc_temp = wibox.widget {
  layout = wibox.container.scroll.horizontal,
  id = 'scroll_container',
  max_size = 345,
  speed = 75,
  expand = true,
  direction = 'h',
  step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
  fps = 30,
  {
    widget = wibox.widget.textbox,
    id     = 'description',
    markup = 'Dust and clouds, -1000°C',
    font   = beautiful.font,
    align  = 'left',
    valign = 'center'
  }
}

local weather_location = wibox.widget {
  layout = wibox.container.scroll.horizontal,
  id = 'scroll_container',
  max_size = 345,
  speed = 75,
  expand = true,
  direction = 'h',
  step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
  fps = 30,
  {
    widget = wibox.widget.textbox,
    id     = 'location',
    markup = 'Earth, Milky Way',
    font   = beautiful.font,
    align  = 'left',
    valign = 'center'
  }
}

local weather_sunrise = wibox.widget {
  widget = wibox.widget.textbox,
  markup = '00:00',
  font   = beautiful.font,
  align  = 'center',
  valign = 'center'
}

local weather_sunset = wibox.widget {
  widget = wibox.widget.textbox,
  markup = '00:00',
  font   = beautiful.font,
  align  = 'center',
  valign = 'center'
}

local weather_data_time = wibox.widget {
  widget = wibox.widget.textbox,
  markup = '00:00',
  font   = beautiful.font,
  align  = 'center',
  valign = 'center'
}

local weather_forecast_tooltip = awful.tooltip {
  text = 'Loading...',
  objects = {weather_icon_widget},
  mode = 'outside',
  align = 'right',
  preferred_positions = {'left', 'right', 'top', 'bottom'},
  margin_leftright = dpi(8),
  margin_topbottom = dpi(8)
}

local weather_report =  wibox.widget {
  widget = wibox.container.background,
  forced_height = dpi(92),
  bg = beautiful.groups_bg,
  shape = beautiful.client_shape_rounded_rectangle,
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
        weather_icon_widget,
        nil
      },
      {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
          layout = wibox.layout.fixed.vertical,
          weather_location,
          weather_desc_temp,
          {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(7),
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(3),
              sunrise_icon_widget,
              weather_sunrise
            },
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(3),
              sunset_icon_widget,
              weather_sunset
            },
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(3),
              refresh_widget,
              weather_data_time
            }
          }
        },
        nil
      }
    }
  }
}


-- Create openweathermap script based on pass mode
-- Mode must be `forecast` or `weather`
local create_weather_script = function(mode)
  local weather_script = [[
  weather=$(curl -sf "http://api.openweathermap.org/data/2.5/]] .. mode ..
      [[?APPID="${apiToken}"&id="${cityId}"&units="°C")

  if [ ! -z "$weather" ]; then
      printf "''${weather}"
  else
      printf "error"
  fi
  ]]

  return weather_script
end

awesome.connect_signal(
  'widget::forecast_fetch',
  function()
    awful.spawn.easy_async_with_shell(
      create_weather_script('forecast'),
      function(stdout)
        if stdout:match('error') then
          weather_forecast_tooltip:set_markup('Can\'t retrieve data!')
        else
          local forecast_data = json.parse(stdout)
          local forecast = ""

          for i = 8, 40, 8 do
            local day = os.date('%A @ %H:%M', forecast_data.list[i].dt)
            local temp = math.floor(forecast_data.list[i].main.temp + 0.5)
            local feels_like = math.floor(forecast_data.list[i].main.feels_like + 0.5)
            local weather = forecast_data.list[i].weather[1].description

            -- Capitalize weather description
            weather = weather:sub(1, 1):upper() .. weather:sub(2)

            forecast = forecast .. '<b>' .. day .. '</b>\n' ..
              'Weather: ' .. weather .. '\n' ..
              'Temperature: ' .. temp .. get_weather_symbol() .. '\n' ..
              'Feels like: ' .. feels_like .. get_weather_symbol() .. '\n\n'

            weather_forecast_tooltip:set_markup(forecast:sub(1, -2))
          end
        end
      end
    )
  end
)

awesome.connect_signal(
  'widget::weather_fetch',
  function()
    awful.spawn.easy_async_with_shell(
      create_weather_script('weather'),
      function(stdout)
        if stdout:match('error') then
          awesome.emit_signal(
            'widget::weather_update',
            '...',
            'Dust and clouds, -1000°C',
            'Earth, Milky Way',
            '00:00',
            '00:00',
            '00:00'
          )
        else
          -- Parse JSON string
          local weather_data = json.parse(stdout)

          -- Process weather data
          local location = weather_data.name
          local country = weather_data.sys.country
          local sunrise = os.date('%H:%M', weather_data.sys.sunrise)
          local sunset = os.date('%H:%M', weather_data.sys.sunset)
          local refresh = os.date('%H:%M', weather_data.dt)
          local temperature = math.floor(weather_data.main.temp + 0.5)
          local weather = weather_data.weather[1].description
          local weather_icon = weather_data.weather[1].icon

          -- Capitalize weather description
          local weather = weather:sub(1, 1):upper() .. weather:sub(2)

          -- Contantenate weather description and symbol
          local weather_description = weather .. ', ' .. temperature .. get_weather_symbol()

          -- Contantenate city and country
          local weather_location = location .. ', ' .. country

          awesome.emit_signal(
            'widget::weather_update',
            weather_icon,
            weather_description,
            weather_location,
            sunrise,
            sunset,
            refresh
          )
        end
      end
    )
  end
)

local update_widget_timer = gears.timer {
  timeout = ${refreshInterval},
  autostart = true,
  call_now  = true,
  single_shot = false,
  callback  = function()
    awesome.emit_signal('widget::weather_fetch')
    awesome.emit_signal('widget::forecast_fetch')
  end
}

awesome.connect_signal('system::network_connected', function()
  awesome.emit_signal('widget::weather_fetch')
  awesome.emit_signal('widget::forecast_fetch')
end)

awesome.connect_signal(
  'widget::weather_update',
  function(code, desc, location, sunrise, sunset, data_receive)
    local icon = icons.weather_error

    local icon_tbl = {
      ['01d'] = icons.sun_icon,
      ['01n'] = icons.moon_icon,
      ['02d'] = icons.dfew_clouds,
      ['02n'] = icons.nfew_clouds,
      ['03d'] = icons.dscattered_clouds,
      ['03n'] = icons.nscattered_clouds,
      ['04d'] = icons.dbroken_clouds,
      ['04n'] = icons.nbroken_clouds,
      ['09d'] = icons.dshower_rain,
      ['09n'] = icons.nshower_rain,
      ['10d'] = icons.d_rain,
      ['10n'] = icons.n_rain,
      ['11d'] = icons.dthunderstorm,
      ['11n'] = icons.nthunderstorm,
      ['13d'] = icons.snow,
      ['13n'] = icons.snow,
      ['50d'] = icons.dmist,
      ['50n'] = icons.nmist,
      ['...'] = icons.weather_error
    }

    icon = icon_tbl[code]

    weather_icon_widget.icon:set_image(icon)
    weather_icon_widget.icon:emit_signal('widget::redraw_needed')

    weather_desc_temp.description:set_markup(desc)
    weather_location.location:set_markup(location)
    weather_sunrise:set_markup(sunrise)
    weather_sunset:set_markup(sunset)
    weather_data_time:set_markup(data_receive)
  end
)

return weather_report
''
