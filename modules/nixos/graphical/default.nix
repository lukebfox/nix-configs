/* System level graphical support. User-graphical environments are configured at
   the home-manager level.
*/
{ config, lib, pkgs, unstablePkgs, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkMerge mkOption mkEnableOption optional types;

  cfg = config.modules.graphical;
in
{

  ##### interface

  options.modules.graphical.enable = mkEnableOption "Enable nixos module for system graphics.";

  ##### implementation

  config = mkIf cfg.enable {

    # Pretty booting.
    boot.plymouth.enable = true;

    # OpenGL support.
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;

    # Use GDM Display Manager.
    services.xserver = {
      enable = true;
      layout = "gb";
      xkbOptions = "ctrl:nocaps";
      libinput = {
        enable = true;
        touchpad.clickMethod = "buttonareas";
        touchpad.naturalScrolling = true;
      };
      # I manage AwesomeWM at the home-manager level, so here I ensure the
      # system display manager (GDM) uses home-manager's xsession by default.
      # see: https://github.com/nix-community/home-manager/issues/1180
      displayManager = {
        gdm.enable = true;
        gdm.autoSuspend = false;
        defaultSession = "home-manager";
        session = [
          { name = "home-manager";
            manage = "desktop";
            start = ''
                ${pkgs.runtimeShell} $HOME/.xsession-hm &
                  waitPID=$!
              '';
          }
        ];
      };
    };

    # System-wide fonts.
    fonts = {
      fonts = attrValues {
        inherit (pkgs)
          fira
          firacode-nerdfont
          font-awesome
          noto-fonts
          noto-fonts-emoji;
      };
      fontconfig = {
        defaultFonts.serif     = [ "Noto Serif" ];
        defaultFonts.sansSerif = [ "Fira Sans" ];
        defaultFonts.monospace = [ "Fura Code NerdFont" ];
        defaultFonts.emoji     = [ "Noto Color Emoji" ];
        # Includes any fonts which may be built by home-manager.
        includeUserConf = true;
      };
    };

    # System-wide packages.
    environment.systemPackages = [
      pkgs.pinentry-gnome
    ] ++ optional config.modules.network.wifi.enable
      pkgs.networkmanagerapplet;

    # Backlight cli.
    programs.light.enable = true;

    # Gnome keyring setup
    # REVIEW better home?
    programs.gnupg.agent = {
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };

    # REVIEW understand these.
    security.pam.services.login.enableGnomeKeyring = true;
    services.gnome3.gnome-keyring.enable = true;
  };
}
