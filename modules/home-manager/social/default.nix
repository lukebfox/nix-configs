{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.social;
in
{

  ##### interface

  options = {
    modules.social.enable = mkEnableOption "Enable home-manager social module.";
  };

  ##### implementation

  config = mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        element-desktop
        signal-desktop
        zoom-us
        jitsi-meet;
      };
  };

}
