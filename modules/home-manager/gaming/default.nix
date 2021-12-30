{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;

  cfg = config.modules.gaming;
in
{

  ##### interface

  options = {

    modules.gaming.enable =
      mkEnableOption "Enable home-manager gaming module.";

    modules.gaming.games = mkOption {
      default = [];
      example = [ pkgs.minecraft ];
      type = types.listOf types.package;
      description = "Choose your games wisely.";
    };

  };

  ##### implementation

  config = mkIf cfg.enable {
    home.packages = cfg.games ++ [
      pkgs.retroarchBare # game emulation
    ];
  };
}
