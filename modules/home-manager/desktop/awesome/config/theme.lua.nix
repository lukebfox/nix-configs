{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (config.gtk) iconTheme font;
  inherit (pkgs) writeText;

in writeText "awesome-theme" ''
local gears      = require('gears')
local beautiful  = require('beautiful')

local filesystem = gears.filesystem
local dpi        = beautiful.xresources.apply_dpi

local icons     = require('icons')

local config_dir = filesystem.get_configuration_dir()
local titlebar_theme = 'stoplight' --TODO make configurable in nix
local tip = config_dir .. '/icons/titlebar/' .. titlebar_theme .. '/'

local theme = {}

--
-- General Variables
--

theme.awesome_icon = icons.awesome
theme.icon_theme   = '${iconTheme.name}'

theme.font      = '${font.name}'
theme.font_bold = 'Fira Bold 10'

-- Default wallpaper path
theme.wallpaper = config_dir .. '/wallpapers/unsplash-ocean.jpg'

--
-- COLOURS
--
theme.base00 = '#${theme.base00-hex}'
theme.base01 = '#${theme.base01-hex}'
theme.base02 = '#${theme.base02-hex}'
theme.base03 = '#${theme.base03-hex}'
theme.base04 = '#${theme.base04-hex}'
theme.base05 = '#${theme.base05-hex}'
theme.base06 = '#${theme.base06-hex}'
theme.base07 = '#${theme.base07-hex}'
theme.base08 = '#${theme.base08-hex}'
theme.base09 = '#${theme.base09-hex}'
theme.base00 = '#${theme.base00-hex}'
theme.base0A = '#${theme.base0A-hex}'
theme.base0B = '#${theme.base0B-hex}'
theme.base0C = '#${theme.base0C-hex}'
theme.base0E = '#${theme.base0E-hex}'
theme.base0F = '#${theme.base0F-hex}'

theme.background  = '#${theme.base01-hex}' .. '77'
theme.accent      = '#${theme.base0D-hex}'

theme.fg_normal = '#${theme.base07-hex}' .. 'de'
theme.bg_normal = theme.background
theme.fg_focus  = '#${theme.base06-hex}'
theme.bg_focus  = '#${theme.base03-hex}'
theme.fg_urgent = '#${theme.base08-hex}'
theme.bg_urgent = '#${theme.base05-hex}'

theme.transparent = '#00000000'

--
-- System tray
--

theme.bg_systray = theme.background
theme.systray_icon_spacing = dpi(16)

--
-- Titlebar
--

theme.titlebar_size = dpi(34)
theme.titlebar_bg_focus  = '#ff006666'
theme.titlebar_bg_normal = '#66666666'
theme.titlebar_fg_focus  = '#ffffff00'
theme.titlebar_fg_normal = '#ffffff00'

theme.titlebar_close_button_normal = tip .. 'close_normal.svg'
theme.titlebar_close_button_focus = tip .. 'close_focus.svg'
theme.titlebar_minimize_button_normal = tip .. 'minimize_normal.svg'
theme.titlebar_minimize_button_focus = tip .. 'minimize_focus.svg'
theme.titlebar_ontop_button_normal_inactive = tip .. 'ontop_normal_inactive.svg'
theme.titlebar_ontop_button_focus_inactive = tip .. 'ontop_focus_inactive.svg'
theme.titlebar_ontop_button_normal_active = tip .. 'ontop_normal_active.svg'
theme.titlebar_ontop_button_focus_active = tip .. 'ontop_focus_active.svg'
theme.titlebar_sticky_button_normal_inactive = tip .. 'sticky_normal_inactive.svg'
theme.titlebar_sticky_button_focus_inactive = tip .. 'sticky_focus_inactive.svg'
theme.titlebar_sticky_button_normal_active = tip .. 'sticky_normal_active.svg'
theme.titlebar_sticky_button_focus_active = tip .. 'sticky_focus_active.svg'
theme.titlebar_floating_button_normal_inactive = tip .. 'floating_normal_inactive.svg'
theme.titlebar_floating_button_focus_inactive = tip .. 'floating_focus_inactive.svg'
theme.titlebar_floating_button_normal_active = tip .. 'floating_normal_active.svg'
theme.titlebar_floating_button_focus_active = tip .. 'floating_focus_active.svg'
theme.titlebar_maximized_button_normal_inactive = tip .. 'maximized_normal_inactive.svg'
theme.titlebar_maximized_button_focus_inactive = tip .. 'maximized_focus_inactive.svg'
theme.titlebar_maximized_button_normal_active = tip .. 'maximized_normal_active.svg'
theme.titlebar_maximized_button_focus_active = tip .. 'maximized_focus_active.svg'

theme.titlebar_close_button_normal_hover = tip .. 'close_normal_hover.svg'
theme.titlebar_close_button_focus_hover = tip .. 'close_focus_hover.svg'
theme.titlebar_minimize_button_normal_hover = tip .. 'minimize_normal_hover.svg'
theme.titlebar_minimize_button_focus_hover = tip .. 'minimize_focus_hover.svg'
theme.titlebar_ontop_button_normal_inactive_hover = tip .. 'ontop_normal_inactive_hover.svg'
theme.titlebar_ontop_button_focus_inactive_hover = tip .. 'ontop_focus_inactive_hover.svg'
theme.titlebar_ontop_button_normal_active_hover = tip .. 'ontop_normal_active_hover.svg'
theme.titlebar_ontop_button_focus_active_hover = tip .. 'ontop_focus_active_hover.svg'
theme.titlebar_sticky_button_normal_inactive_hover = tip .. 'sticky_normal_inactive_hover.svg'
theme.titlebar_sticky_button_focus_inactive_hover = tip .. 'sticky_focus_inactive_hover.svg'
theme.titlebar_sticky_button_normal_active_hover = tip .. 'sticky_normal_active_hover.svg'
theme.titlebar_sticky_button_focus_active_hover = tip .. 'sticky_focus_active_hover.svg'
theme.titlebar_floating_button_normal_inactive_hover = tip .. 'floating_normal_inactive_hover.svg'
theme.titlebar_floating_button_focus_inactive_hover = tip .. 'floating_focus_inactive_hover.svg'
theme.titlebar_floating_button_normal_active_hover = tip .. 'floating_normal_active_hover.svg'
theme.titlebar_floating_button_focus_active_hover = tip .. 'floating_focus_active_hover.svg'
theme.titlebar_maximized_button_normal_inactive_hover = tip .. 'maximized_normal_inactive_hover.svg'
theme.titlebar_maximized_button_focus_inactive_hover = tip .. 'maximized_focus_inactive_hover.svg'
theme.titlebar_maximized_button_normal_active_hover = tip .. 'maximized_normal_active_hover.svg'
theme.titlebar_maximized_button_focus_active_hover = tip .. 'maximized_focus_active_hover.svg'

--
-- UI
--

-- Groups
theme.groups_title_bg = '#${theme.base07-hex}' .. '15'
theme.groups_bg       = '#${theme.base07-hex}' .. '10'
theme.groups_radius   = dpi(9)
theme.groups_shape_rounded_rectangle = function (cr, width, height)
  gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, theme.groups_radius)
end

-- Events
theme.leave_event   = transparent
theme.enter_event   = '#${theme.base07-hex}' .. '10'
theme.press_event   = '#${theme.base07-hex}' .. '15'
theme.release_event = '#${theme.base07-hex}' .. '10'

--
-- Client Decorations
--

-- Borders
theme.border_focus   = '#${theme.base04-hex}'
theme.border_unfocus = '#${theme.base04-hex}'
theme.border_marked  = '#${theme.base08-hex}'
theme.border_width   = dpi(0)
theme.border_radius  = dpi(9)

-- Decorations
theme.useless_gap = dpi(4)
theme.client_shape_rectangle = gears.shape.rectangle
theme.client_shape_rounded_rectangle = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, dpi(6))
end

--
-- Menu
--

theme.menu_font    = theme.font
theme.menu_submenu = "" -- ➤

theme.menu_height       = dpi(34)
theme.menu_width        = dpi(200)
theme.menu_border_width = dpi(20)
theme.menu_bg_focus     = theme.accent .. 'CC'

theme.menu_bg_normal    = theme.background:sub(1,7) .. '33'
theme.menu_fg_normal    = '#${theme.base05-hex}'
theme.menu_fg_focus     = '#${theme.base06-hex}'
theme.menu_border_color = theme.background:sub(1,7) .. '5C'

--
-- Tooltips
--

theme.tooltip_bg           = theme.background
theme.tooltip_border_color = theme.transparent
theme.tooltip_border_width = dpi(0)
theme.tooltip_gaps         = dpi(5)
theme.tooltip_shape        = theme.client_shape_rounded_rectangle

-- Separators
theme.separator_color = '#${theme.base04-hex}'

-- Layoutbox icons
theme.layout_max      = icons.max
theme.layout_tile     = icons.tile
theme.layout_dwindle  = icons.dwindle
theme.layout_floating = icons.floating

--
-- Taglist
--

theme.taglist_bg_empty    = theme.background:sub(1,7) .. '99'
theme.taglist_bg_occupied = '#${theme.base01-hex}' .. '1A'
theme.taglist_bg_urgent   = '#${theme.base08-hex}' .. '99'
theme.taglist_bg_focus    = theme.background
theme.taglist_spacing     = dpi(0)

--
-- Notification
--

theme.notification_position             = 'top_right'
theme.notification_bg                   = theme.transparent
theme.notification_margin               = dpi(5)
theme.notification_border_width         = dpi(0)
theme.notification_border_color         = theme.transparent
theme.notification_spacing              = dpi(5)
theme.notification_icon_resize_strategy = 'center'
theme.notification_icon_size            = dpi(32)

-- Client Snap Theme
theme.snap_bg           = theme.background
theme.snap_shape        = theme.client_shape_rectangle
theme.snap_border_width = dpi(15)

-- Hotkey popup
theme.hotkeys_font             = theme.font
theme.hotkeys_description_font = theme.font
theme.hotkeys_bg               = theme.background
theme.hotkeys_group_margin     = dpi(20)

return theme
''
