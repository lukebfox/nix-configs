{ nixosConfig
, config
, lib
, pkgs
, unstablePkgs
, secrets
, utilities
, ... } @ args:
let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkEnableOption;
  inherit (config.lib.base16) theme;

  cfg = config.modules.desktop.sway;
in
{

  imports = [
    ./..
    ./waybar.nix   # bar
    ./mako.nix     # notifications
    ./redshift.nix # nightlight
    ./kanshi.nix   # ~autorandr
    ./termite.nix  # terminal
  ];

  ##### interface

  options.modules.desktop.sway.enable = mkEnableOption "Enable sway window manager";

  ##### implementation

  config = mkIf cfg.enable {

    # Install required user packages.
    home.packages = attrValues {
      inherit (pkgs)
        swaybg        # background tool
        swayidle      # idle inhibitor
        rofi          # menu launcher
        grim          # screenshot tool
        wl-clipboard; # clipboard
    };

    wayland.windowManager.sway =
      let
        mod = "Mod4";
        background = import ./logo-wallpaper.nix args;
      in {
        enable = true;
        systemdIntegration = true; # makes a sway-session user target
        config = {
          assigns = {
            "1" = [{ class = "Code"; } { class = "Emacs"; }];
            "2" = [{ title = "Firefox"; }];
            "3" = [{ class = "Mendeley\ Desktop"; } { class = "DevDocs"; }];
            "4" = [{ class = "Element"; }];
            "5" = [{ class = "Spotify"; }];
            "6" = [{ class = "VirtualBox Manager"; }];
          };
          colors = {
            focused = {
              background  = theme.base02-hex;
              border      = theme.base04-hex;
              childBorder = theme.base04-hex;
              indicator   = theme.base04-hex;
              text        = theme.base03-hex;
            };
            focusedInactive = {
              background  = theme.base01-hex;
              border      = theme.base04-hex;
              childBorder = theme.base04-hex;
              indicator   = theme.base04-hex;
              text        = theme.base03-hex;
            };
            placeholder = {
              background  = theme.base01-hex;
              border      = theme.base04-hex;
              childBorder = theme.base04-hex;
              indicator   = theme.base04-hex;
              text        = theme.base03-hex;
            };
            unfocused = {
              background  = theme.base01-hex;
              border      = theme.base04-hex;
              childBorder = theme.base04-hex;
              indicator   = theme.base04-hex;
              text        = theme.base03-hex;
            };
            urgent = {
              background  = theme.base08-hex;
              border      = theme.base08-hex;
              childBorder = theme.base04-hex;
              indicator   = theme.base08-hex;
              text        = theme.base06-hex;
            };
          };
          floating = {
            border = 1;
            criteria = [
              { class  = "Bitwarden"; }
              { app_id = "nm-connection-editor"; }
              { title  = "htop"; }
            ];
            modifier = mod;
          };
          fonts = [ "FontAwesome 10" ] ++ nixosConfig.fonts.fontconfig.defaultFonts.sansSerif;
          gaps = {
            inner = 20;
            outer = 5;
            smartGaps = true;
          };
          input =  {
            "2:7:SynPS/2_Synaptics_TouchPad" = {
              tap = "enabled";
              drag = "enabled";
              natural_scroll = "enabled";
            };
            "1:1:AT_Translated_Set_2_keyboard" = {
              xkb_layout = "gb";
              xkb_options = "ctrl:nocaps";
            };
            # Wireless Mouse & Keyboard
            "1133:16468:Logitech_Wireless_Mouse" = {
              drag = "enabled";
              natural_scroll = "enabled";
            };
            "1133:16419:Logitech_Wireless_Keyboard_PID:4023" = {
              xkb_layout = "gb";
              xkb_options = "ctrl:nocaps";
            };
          };
          output = {
            "eDP-1" = {
              resolution = "1920x1080";
              position = "0,0";
              bg = "${background} fill";
            };
            "HDMI-A-1" = {
              resolution = "1920x1080";
              position = "1920,0";
              bg = "${background} fill";
            };
          };
          keyBindings = {
            "${mod}+Shift+r" = "reload";
            "${mod}+Shift+q" = "exec swaynag -t warning -m 'Do you really want to end your wayland session?' -b 'Yes, exit sway' 'swaymsg exit'";

            "${mod}+Return"  = "exec ${pkgs.termite}/bin/termite";
            "${mod}+d"       = "exec ${pkgs.rofi}/bin/rofi";
            "${mod}+n"       = "exec makoctl dismiss";
            "${mod}+Shift+n" = "exec makoctl dismiss --all";
            "${mod}+q"       = "kill";

            "${mod}+minus"     = "splitv";
            "${mod}+backslash" = "splith";

            "${mod}+q" = "layout toggle split";
            "${mod}+w" = "layout tabbed";
            "${mod}+e" = "layout stacking";
            "${mod}+f" = "fullscreen";
            "${mod}+a" = "focus parent";

            "${mod}+Shift+space" = "floating toggle";
            "${mod}+space"       = "focus mode_toggle";

            "${mod}+Shift+grave" = "move scratchpad";
            "${mod}+grave"       = "scratchpad show";


            "${mod}+Tab"       = "workspace next";
            "${mod}+Shift+Tab" = "workspace prev";

            "${mod}+0" = "workspace 0";
            "${mod}+1" = "workspace 1";
            "${mod}+2" = "workspace 2";
            "${mod}+3" = "workspace 3";
            "${mod}+4" = "workspace 4";
            "${mod}+5" = "workspace 5";
            "${mod}+6" = "workspace 6";

            "${mod}+r" = "mode \"resize\"";
          };
          menu = "";
          modes.resize = {
            Left   = "resize shrink width 20px";
            Up     = "resize shrink height 20px";
            Right  = "resize grow width 20px";
            Down   = "resize grow height 20px";
            Return = "mode \"default\"";
            Escape = "mode \"default\"";
          };
          modifier = mod;
          window = {
            border = 1;
            commands = [
              { command = "opacity 0.8";
                criteria.appid = "termite";
              }
            ];
          };
          workspaceBackAndForth = true;
          xwayland = true;
        };
      };

    # TODO

    ########################### SystemD ##########################

    ## Sway compositor systemd user service
    #systemd.user.services.sway = {
    #  description = "Sway - Wayland window manager";
    #  documentation = [ "man:sway(5)" ];
    #  bindsTo = [ "graphical-session.target" ];
    #  wants = [ "graphical-session-pre.target" ];
    #  after = [ "graphical-session-pre.target" ];
    #  # We explicitly unset PATH here, as we want it to be set by
    #  # systemctl --user import-environment in startsway
    #  environment.PATH = lib.mkForce null;
    #  serviceConfig = {
    #    Type = "simple";
    #    ExecStart = ''
    #      ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
    #    '';
    #    Restart = "on-failure";
    #    RestartSec = 1;
    #    TimeoutStopSec = 10;
    #  };
    #};
  };
}
