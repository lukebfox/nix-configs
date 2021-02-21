{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues readFile;
  inherit (lib) concatStringsSep literalExample mapAttrsToList mkEnableOption mkIf mkOption types;

  cfg = config.modules.programs.colorls;
in
{
  ##### interface

  options = {
    modules.programs.colorls.enable = mkEnableOption "Enable home-manager module for colorls.";

    modules.programs.colorls.colors = mkOption {
      default = {};
      example = literalExample ''
        {
          unrecognized_file = "blue";
          recognised_file = "#ffffff";
          dir = "blue";
        }
      '';
      type = types.attrsOf types.str;
      description = "TODO";
    };
  };

  ##### implementation

  config = mkIf cfg.enable {

    home.packages = [ pkgs.colorls ];

    xdg.configFile."colorls/dark_colors.yaml".text =
      concatStringsSep "\n" (mapAttrsToList (k: v: "${k}: ${v}") cfg.colors);

  };

}
