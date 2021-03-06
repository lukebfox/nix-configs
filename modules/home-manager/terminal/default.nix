{ config, lib, pkgs, ... } @ args:

let
  inherit (builtins) head;
  inherit (lib) fileContents mkIf mkEnableOption;

  cfg = config.modules.terminal;
in
{

  ##### interface

  options.modules.terminal.enable = mkEnableOption "Enable home-manager terminal module.";

  ##### implementation

  config = mkIf cfg.enable {};

}
