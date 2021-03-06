# Wayland bar.
{ nixosConfig, config, lib, pkgs, secrets, ... }:
let
  inherit (lib) mkIf;
  inherit (secrets) github-api-token;
  inherit (config.lib.base16) base16template;

  fetch-github-notifications = pkgs.writeShellScript "fetch-github-notifications" ''
    count=$(curl -u username:${github-api-token} https://api.github.com/notifications |\
         ${pkgs.jq}/bin/jq '. | length')

    if [[ "$count" != "0" ]]; then
         echo '{"text":'$count',"tooltip":"$tooltip","class":"$class"}'
    fi
  '';

  top-bar = {
    layer = "bottom";
    position = "top";
    output = [ "eDP-1" "HDMI-A-1" ];
    modules-left = [
      "mpd"
    ];
    modules-center = [
      "clock#time"
      "clock#day"
      "clock#date"
    ];
    modules-right = [
      "idle_inhibitor"
      "custom/github"
      "disk"
      "cpu"
      "memory"
      "pulseaudio"
      "backlight"
      "network"
      "battery"
    ];
    modules = {
      backlight = {
        format = "{icon}";
        format-icons = [
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free Solid\"></span>"
        ];
      };
      battery = {
        states = {
          good = 80;
          warning = 30;
          critical = 15;
        };
        tooltip = false;
        format = "{icon}";
        format-charging = "<span font_family=\"Font Awesome 5 Free\"></span>";
        format-full = "";
        format-icons = [
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free\"></span>"
          "<span font_family=\"Font Awesome 5 Free\"></span>"
        ];
      };
      "clock#day" = {
        format = "{:%a}";
        tooltip = false;
      };
      "clock#time" = {
        format = "{:%I:%M%p}";
        tooltip = false;
      };
      "clock#date" = {
        format = "{:%d %B}";
        tooltip = false;
      };
      "custom/github" = {
        format = "<span font_family=\"Font Awesome 5 Free\"></span> {}";
        return-type = "json";
        interval = 60;
        exec = fetch-github-notifications;
        on-click = "firefox https://github.com/notifications";
      };
      "custom/media" = {
        format = "{icon} {}";
        return-type = "json";
        max-length = 50;
        format-icons = {
          spotify = "<span foreground=\"#1db954\"></span>";
          default = "🎜";
        };
        escape = true;
      };
      disk = {
        interval = 30;
        format = "<span font_family=\"Font Awesome 5 Free\"></span> {percentage_used}%";
        path = "/";
        tooltip = false;
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip = false;
      };
      cpu = {
        interval = 1;
        format = "<span font_family=\"Font Awesome 5 Free\"></span> {usage:2}%";
        tooltip = false;
      };
      memory = {
        interval = 1;
        format = "<span font_family=\"Font Awesome 5 Free Solid\"></span> {percentage:2}%";
        tooltip = false;
      };
      mpd = {
        server = "159.69.18.76";
        port = 6600;
        interval = 1;
        format = "<span font_family=\"Font Awesome 5 Free Solid\"></span> {artist} - {title}";
        tooltip = false;
      };
      network = {
        interval = 1;
        interface = "wlo1";
        format-wifi = "<span font_family=\"Font Awesome 5 Free\"></span> {signalStrength:2}%";
        format-ethernet = "<span font_family=\"Font Awesome 5 Free\"></span>";
        format-linked = "<span font_family=\"Font Awesome 5 Free Solid\"></span>";
        format-disconnected = "";
        tooltip = false;
      };
      pulseaudio = {
        format = "{icon}";
        format-bluetooth = "{icon} ";
        format-muted = "<span font_family=\"Font Awesome 5 Free\"></span>";
        format-source = "";
        format-source-muted = "";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            "<span font_family=\"Font Awesome 5 Free\"></span>"
            "<span font_family=\"Font Awesome 5 Free\"></span>"
            "<span font_family=\"Font Awesome 5 Free\"></span>"
          ];
        };
      };
      "sway/mode" = {
        format = "{}";
      };
      tray = {
        icon-size = 21;
        spacing = 5;
      };
    };
  };

  bottom-bar = {
    layer = "bottom";
    position = "bottom";
    height = "10px";
    modules-center = [ "sway/workspaces" ];
    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      format-icons = {
        urgent =  "<span font_family=\"font awesome 5 free\"></span>";
        focused = "<span font_family=\"font awesome 5 free\"></span>";
        default = "<span font_family=\"font awesome 5 free\"></span>";
      };
    };
  };

  colours = base16template "waybar";

in mkIf config.modules.desktop.sway.enable {

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [ top-bar bottom-bar ];
    style = ''
      @import "${base16template "waybar"}";
      @define-color spotify #1c8a43;

      * {
          font-family: "Comfortaa";
          font-size: 15px;
          border: none;
          border-radius: 0;
          background: transparent;
          min-height: 0;
          color: @base06;
      }

      #workspaces button {
          font-family: "Font Awesome 5";
          margin-bottom: 20px;
      }

      #tray {
          margin-bottom: 3px;
      }

      #backlight, #battery, #clock,
      #cpu, #custom-github, #disk,
      #idle_inhibitor, #memory,
      #mode, #mpd, #network,
      #pulseaudio, #tray {
          padding: 0 7px;
      }

      #clock, #mpd {
          color: @base07;
      }

      #backlight, #battery, #clock.date,
      #cpu, #custom-github, #disk,
      #idle_inhibitor, #memory,
      #mode, #network, #pulseaudio {
          color: @base00;
      }

      #clock.time, #clock.date {
          padding: 0;
      }

      #clock.day  {
          padding: 0 21px 0 7px;
      }

      #mode {
          font-style: italic;
          background: @base0D;
      }

      #pulseaudio.muted {
          color: @base09;
      }

      #battery.critical {
          color: @base08;
      }
    '';
  };
}
