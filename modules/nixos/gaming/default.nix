{ config, lib, pkgs, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkMerge mkOption mkEnableOption types;

  cfg = config.modules.gaming;
in
{

  ##### interface

  options = {
    modules.gaming.enable = mkEnableOption "Enable nixos gaming module.";

    modules.gaming.steam.enable = mkEnableOption "Enable steam.";
  };

  ##### implementation

  config = mkIf cfg.enable (mkMerge [

    {
      # Graphics and Audio hardware support.
      hardware.opengl.enable = true;
      hardware.pulseaudio.enable = true;

      # FPS games on laptop need this.
      services.xserver.libinput.touchpad.disableWhileTyping = false;

      # Improve WINE performance.
      environment.sessionVariables = { WINEDEBUG = "-all"; };
    }

    (mkIf cfg.steam.enable {

      # 32-bit support needed for Steam.
      hardware.opengl.driSupport32Bit = true;
      hardware.pulseaudio.support32Bit = true;

      environment.systemPackages = attrValues {
        inherit (pkgs) steam steam-run;
      };

      # Better for Steam Proton games.
      systemd.extraConfig = "DefaultLimitNOFILE=1048576";

    } // import ./udev.nix)

  ]);
}
