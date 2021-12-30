{ config, lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep literalExpression mapAttrsToList mkEnableOption mkIf mkOption types;

  cfg = config.modules.cli.colorls;
in
{
  ##### interface

  options = {
    modules.cli.colorls.enable = mkEnableOption "Enable home-manager module for colorls.";

    modules.cli.colorls.colors = mkOption {
      default =
        {
          # Main Colors
          unrecognized_file = "blue";
          recognized_file =   "white";
          dir =               "blue";
          # Link
          dead_link = "red";
          link =      "cyan";
          # special files
          socket =    "yellow";
          blockdev =  "yellow";
          chardev =   "yellow";
          # Access Modes
          read =      "green";
          write =     "yellow";
          exec =      "red";
          no_access = "black";
          # Age
          day_old =     "lightgray";
          hour_old =    "white";
          no_modifier = "gray";
          # File Size
          file_large =  "red";
          file_medium = "yellow";
          file_small =  "white";
          # Random
          report = "white";
          user =   "cyan";
          normal = "darkkhaki";
          tree =   "blue";
          empty =  "blue";
          error =  "red";
          # Git
          addition =     "green";
          modification = "yellow";
          deletion =     "red";
          untracked =    "magenta";
          unchanged =    "white";
        };
      example = literalExpression ''
        {
          unrecognized_file = "blue";
          recognised_file = "#ffffff";
        }
      '';
      type = types.attrsOf types.str;
      description = "TODO";
    };
  };

  ##### implementation

  config = mkIf cfg.enable {

    fonts.fontconfig.enable = true;

    home.packages = [ pkgs.colorls pkgs.firacode-nerdfont ];

    xdg.configFile."colorls/dark_colors.yaml".text =
      concatStringsSep "\n" (mapAttrsToList (k: v: "${k}: ${v}") cfg.colors);

  };

}
