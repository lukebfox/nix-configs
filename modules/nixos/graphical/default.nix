/* System level graphical support. User-graphical environments are configured at
   the home-manager level.
*/
{ config, lib, pkgs, unstablePkgs, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkEnableOption optional;

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
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    # X Configuration.
    services.xserver = {
      enable = true;
      layout = "gb";
      xkbOptions = "ctrl:nocaps";
      libinput = {
        enable = true;
        touchpad.clickMethod = "buttonareas";
        touchpad.naturalScrolling = true;
      };
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = false; # helpful for razer
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
    # REVIEW better home for this than graphical profile? should this be done with hm?
    programs.gnupg.agent = {
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };

    # REVIEW understand these.
    services.dbus.packages = [ pkgs.dconf ];
    security.pam.services.login.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
