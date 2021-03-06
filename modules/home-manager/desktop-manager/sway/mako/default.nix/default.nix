{ config, lib, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (lib) mkIf mkOption types;

  cfg = config.programs.mako;

  sectionType = types.submodule ({...}: {
    options = {
      backgroundColor = mkOption {
        example = "#333333";
        type = types.str;
      };
      textColor = mkOption {
        example = "#EEEEEE";
        type = types.str;
      };
      borderColor = mkOption {
        example = "#555555";
        type = types.str;
      };
      format = mkOption {
        default = "%a - %s\n%b";
        type = types.str;
      };
    };
  });

in
{
  ##### interface

  options = {

    programs.mako.lowUrgency = mkOption {
      type = sectionType;
      description = "TODO";
    };

    programs.mako.normalUrgency = mkOption {
      type = sectionType;
      description = "TODO";
    };

    programs.mako.highUrgency = mkOption {
      type = sectionType;
      description = "TODO";
    };

    programs.mako.hiddenFormat = mkOption {
      default = "%h more";
      type = types.str;
    };
  };

  ##### implementation TODO

  config = mkIf cfg.enable {};
}
