{ nixosConfig, config, lib, pkgs, utilities, ... }:
let
  inherit (config.modules.desktop.awesome) defaultPrograms;
  inherit (pkgs) writeText;

in writeText "awesome-apps-config" ''

local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'

return {
  -- The default applications that we will use in keybindings and widgets
  default = {
    -- Default terminal emulator
    terminal = '${defaultPrograms.terminal.exec}',
    -- Default web browser
    web_browser = '${defaultPrograms.browser.exec}',
    -- Default text editor
    text_editor = '${defaultPrograms.editor.exec}',
    -- Default IDE
    development = '${defaultPrograms.editor.exec}',
    -- Default media player
    multimedia = '${defaultPrograms.media.exec}',
    -- Default game, can be a launcher like steam
    game = '${defaultPrograms.games.exec}',
    -- Default graphics editor
    graphics = '${defaultPrograms.graphics.exec}',
    -- Default social TODO
    social = '${defaultPrograms.social.exec}',
    -- Default sandbox
    sandbox = '${defaultPrograms.sandbox.exec}',
    -- Default file manager
    file_manager = '${defaultPrograms.files.exec}',
    -- Default network manager TODO
    network_manager = "",
    -- Default bluetooth manager
    bluetooth_manager = 'blueman-manager',
    -- Default power manager TODO
    power_manager = "",
    -- Default locker
    lock = 'awesome-client "awesome.emit_signal(\'component::lockscreen_show\')"',
    -- Default quake terminal
    quake = 'kitty --name QuakeTerminal',
    -- Default rofi global menu
    rofi_global = 'rofi -dpi ' .. screen.primary.dpi ..
      ' -show "Global Search" -modi "Global Search":' .. config_dir ..
      '/configuration/rofi/global/rofi-spotlight.sh' ..
      ' -theme ' .. config_dir ..
      '/configuration/rofi/global/rofi.rasi',
    -- Default app menu
    rofi_appmenu = 'rofi -dpi ' .. screen.primary.dpi ..
      ' -show drun -theme ' .. config_dir ..
      '/configuration/rofi/appmenu/rofi.rasi'
  },

  -- List of apps to start once on start-up
  run_on_start_up = {
    -- Compositor
    'picom -b --experimental-backends --dbus --config ${config.xdg.configHome}/picom/picom.conf',
    -- Blueman applet
    --'blueman-applet',
    -- NetworkManager applet
    --'nm-applet',
    -- Polkit and keyring
    --'/usr/bin/lxqt-policykit-agent &' ..
    -- ' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',
    -- Load X colors
    'xrdb $HOME/.Xresources',
    -- Lockscreen timer
    [[
      xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
       "awesome-client 'awesome.emit_signal(\"component::lockscreen_show\")'" ""
    ]]
  },

  -- List of binaries/shell scripts that will execute for a certain task
  utils = {
    -- Fullscreen screenshot
    full_screenshot = utils_dir .. 'snap full',
    -- Area screenshot
    area_screenshot = utils_dir .. 'snap area',
    -- Update profile picture
    update_profile  = utils_dir .. 'profile-image'
  }
}
''
