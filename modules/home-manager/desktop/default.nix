{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption mkMerge types;

  cfg = config.modules.desktop;
in
{

  ##### interface

  options = {

    modules.desktop.enable =
      mkEnableOption "Enable home-manager desktop module.";

    modules.desktop.gaming.enable =
      mkEnableOption "Enable home-manager desktop gaming submodule.";

    modules.desktop.gaming.games = mkOption {
      default = [];
      example = [ pkgs.minecraft ];
      type = types.listOf types.package;
      description = "Choose your games wisely.";
    };

    modules.desktop.multimedia.enable =
      mkEnableOption "Enable home-manager desktop multimedia submodule.";

    modules.desktop.social.enable =
      mkEnableOption "Enable home-manager desktop social submodule.";
  };

  ##### implementation

  config = mkIf cfg.enable {

    # XDG desktop specification
    xdg = {
      enable = true;
      userDirs.enable = true;
      userDirs.extraConfig.XDG_PROJECTS_DIR = "$HOME/Projects";
    };

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

    home.packages = [
      pkgs.spotify
    ] ++ lib.optionals cfg.gaming.enable ([
      pkgs.retroarchBare # emulators
    ] ++ cfg.gaming.games
    ) ++ lib.optionals cfg.multimedia.enable [
      pkgs.transmission  # torrent client
      pkgs.nicotine-plus # soulseek
      pkgs.gimp          # image editor
      pkgs.inkscape      # svg editor
      pkgs.vlc           # video player
    ] ++ lib.optionals cfg.social.enable [
      pkgs.element-desktop
      pkgs.signal-cli
      pkgs.signal-desktop
      pkgs.skype
      pkgs.teams
      pkgs.zoom-us
    ];
  };
}
