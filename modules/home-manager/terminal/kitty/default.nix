{ config, lib, pkgs, ... } @ args:

let
  inherit (builtins) head;
  inherit (config.lib.base16) base16template;
  inherit (lib) fileContents mkIf mkEnableOption;

  colours = fileContents (base16template "kitty");

  cfg = config.modules.terminal.kitty;
in
{

  ##### interface

  options.modules.terminal.kitty.enable = mkEnableOption "Enable home-manager module for kitty.";

  ##### implementation

  config = mkIf cfg.enable {

    programs.kitty = {
      enable = true;
      inherit (config.gtk) font;
      extraConfig = colours;
      keybindings = {
        "ctrl+shift+v" = "paste_from_clipboard";
        "ctrl+shift+s" = "paste_from_selection";
        "ctrl+shift+c" = "copy_to_clipboard";
        "shift+i"      = "paste_from_selection";

        "ctrl+shift+u"         = "scroll_line_up";
        "ctrl+shift+d"         = "scroll_line_down";
        "ctrl+shift+k"         = "scroll_line_up";
        "ctrl+shift+j"         = "scroll_line_down";
        "ctrl+shift+page_u"    = "scroll_page_up";
        "ctrl+shift+page_down" = "scroll_page_down";
        "ctrl+shift+home"      = "scroll_home";
        "ctrl+shift+end"       = "scroll_end";
        "ctrl+shift+h"         = "show_scrollback";

        "ctrl+shift+enter" = "new_window";
        "ctrl+shift+n"     = "new_os_window";
        "ctrl+shift+w"     = "close_window";
        "ctrl+shift+]"     = "next_window";
        "ctrl+shift+["     = "previous_window";
        "ctrl+shift+f"     = "move_window_forward";
        "ctrl+shift+b"     = "move_window_backward";
        "ctrl+shift+`"     = "move_window_to_top";
        "ctrl+shift+1"     = "first_window";
        "ctrl+shift+2"     = "second_window";
        "ctrl+shift+3"     = "third_window";
        "ctrl+shift+4"     = "fourth_window";
        "ctrl+shift+5"     = "fifth_window";
        "ctrl+shift+6"     = "sixth_window";
        "ctrl+shift+7"     = "seventh_window";
        "ctrl+shift+8"     = "eighth_window";
        "ctrl+shift+9"     = "ninth_window";
        "ctrl+shift+0"     = "tenth_window";

        "ctrl+shift+right" = "next_tab";
        "ctrl+shift+left"  = "previous_tab";
        "ctrl+shift+t"     = "new_tab";
        "ctrl+shift+q"     = "close_tab";
        "ctrl+shift+l"     = "next_layout";
        "ctrl+shift+."     = "move_tab_forward";
        "ctrl+shift+,"     = "move_tab_backward";
        "ctrl+shift+alt+t" = "set_tab_title";

        "ctrl+shift+equal" = "increase_font_size";
        "ctrl+shift+minus" = "decrease_font_size";
        italic_font         = "auto";
      };
      settings = {
        bold_font           = "auto";
        bold_italic_font    = "auto";
        adjust_line_height  = 0;
        adjust_column_width = 0;

        # Cursor
        cursor_shape               = "beam";
        cursor_blink_interval      = "-1";
        cursor_stop_blinking_after = 15;

        # Scrollback
        scrollback_lines        = 10000;
        scrollback_pager        = "${pkgs.less}bin/less";
        wheel_scroll_multiplier = 5;

        # URLs
        url_style          = "double";
        open_url_modifiers = "ctrl+shift";
        open_url_with      = "default";
        copy_on_select     = true;

        # Selection
        rectangle_select_modifiers = "ctrl+shift";
        select_by_word_characters  = ":@-./_~?&=%+#";

        # Mouse
        click_interval      = "0.5";
        mouse_hide_wait     = 0;
        focus_follows_mouse = false;

        # Performance
        repaint_delay   = 20;
        input_delay     = 2;
        sync_to_monitor = false;

        # Bell
        visual_bell_duration = 0;
        enable_audio_bell    = false;
        bell_on_tab          = false;

        # Window
        remember_window_size    = false;
        initial_window_width    = 700;
        initial_window_height   = 400;
        window_border_width     = 0;
        window_margin_width     = 12;
        window_padding_width    = 10;
        inactive_text_alpha     = 1;
        background_opacity      = "0.5";
        placement_strategy      = "center";
        hide_window_decorations = true;

        # Layouts
        enabled_layouts = "*";

        # Tabs
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_bar_margin_width = "0.0";
        tab_separator = " ｜ ";
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";

        # Shell
        shell  = ".";
        close_on_child_death = false;
        allow_remote_control = true;
        term = "kitty";
      };
    };
  };
}
