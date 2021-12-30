{ config, lib, pkgs, ... }:

let
  inherit (config.lib.base16) base16template;
  inherit (lib) fileContents mkIf mkEnableOption;

  colours = fileContents (base16template "iterm2");

  cfg = config.modules.cli.iterm2;
in
{

  ##### interface

  options.modules.cli.iterm2.enable = mkEnableOption "Enable home-manager module for iterm2.";

  ##### implementation

  config = mkIf cfg.enable {

    home.packages = [ pkgs.iterm2 ];

    xdg.configFile."iterm2/nix.itermcolors".text = colours;

  };

}
