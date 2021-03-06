{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption mkMerge types;

  cfg = config.modules.desktop-manager;
in
{
  ##### interface

  options = {

    modules.desktop-manager.enable =
      mkEnableOption "Enable home-manager desktop module.";

  };

  ##### implementation

  config = mkIf cfg.enable {

    # XServer configuration (both Xorg and Wayland use X).
    xsession = {
      enable = true;
      scriptPath = ".xsession-hm";
      pointerCursor.package = pkgs.bibata-extra-cursors;
      pointerCursor.name = "Bibata_Pink";
      pointerCursor.size = 24;
    };

    # GTK configuration
    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-cursor-theme-name = "Bibata_Pink";
      font.package = pkgs.fira;
      font.name = "Fira 10";
      theme.package = pkgs.arc-theme;
      theme.name = "Arc";
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "Papirus";
    };

    home.packages = lib.optionals cfg.multimedia.enable [
      pkgs.transmission  # torrent client
      pkgs.nicotine-plus # soulseek
      pkgs.gimp          # image editor
      pkgs.inkscape      # svg editor
      pkgs.vlc           # video player
    ];
  };
}
