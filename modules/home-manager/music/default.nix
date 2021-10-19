{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption mkMerge types;

  cfg = config.modules.music;
in
{

  ##### interface

  options = {

    modules.music.enable =
      mkEnableOption "Enable home-manager music module.";

  };

  ##### implementation

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.spotify
    ];
  };
}
