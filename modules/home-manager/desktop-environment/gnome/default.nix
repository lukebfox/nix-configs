# TODO actually modularise
{ config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.desktop-environment.gnome;
in
{

  ##### interface

  options = {
    modules.desktop-environment.gnome.enable = mkEnableOption "Enable gnome desktop environment";
  };

  ##### implementation

  config = mkIf cfg.enable {

    home.file.".themes/WhiteSur".source = pkgs.whitesur-gnome;

    home.packages = attrValues {
      # Dependencies
      inherit (pkgs)
        bibata-extra-cursors;
      # Development packages
      inherit (pkgs.gnome)
        gnome-tweaks
        dconf-editor;
      # Extensions
      inherit (pkgs.gnomeExtensions)
        dash-to-dock
        caffeine
        hide-activities-button
        blur-my-shell
        ;
    };

    # GTK Configuration
    gtk = {
      enable = true;
      font = {
        package = pkgs.fira;
        name = "Fira 10";
      };
      theme = {
        package = pkgs.whitesur-gtk-theme;
        name = "WhiteSur-light-solid-pink";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };

    # Gnome Configuration
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "file://" + ../../../../data/wallpapers/nixos.png;
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        clock-show-weekday = true;
        cursor-theme = "Bibata_Pink";
        enable-hot-corners = false;
        show-battery-percentage = true;
      };
      "org/gnome/gnome-session" = {
        auto-save-session = true;
      };
      "org/gnome/mutter" = {
        center-new-windows = true;
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = 1400;
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-user-extensions = [];
        disable-extension-version-validation = true;
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "Hide_Activities@shay.shayel.org"
          "caffeine@patapon.info"
          "blur-my-shell@aunetx"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        # position
        dock-position = "BOTTOM";
        dock-fixed = false;
        extend-height = false;
        # icons
        dash-max-icon-size = 48;
        icon-size-fixed = true;
        show-apps-at-top = true;
        # clicking
        click-action = "previews";
        scroll-action =  "cycle-windows";
        shift-click-action = "launch";
        middle-click-action = "minimise";
        shift-middle-click-action = "launch";
        running-indicator-dominant-color = true;
        running-indicator-style = "DASHES";
        # visibility
        intellihide = true;
        isolate-workspaces=true;
        autohide = true;
        autohide-in-full-screen = true;
        require-pressure-to-show = true;
        # transparency
        transparency-mode = "FIXED";
        background-opacity = 0.1;
      };
      "org/gnome/shell/extensions/blur-my-shell" = {
        blur-dash = false;
        blur-panel = false;
        brightness = 0.75;
        sigma = 25;
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "WhiteSur-light-solid-pink";
      };
    };
  };
}
