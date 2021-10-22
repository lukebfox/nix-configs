{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli;
in
{
  ##### bundled modules

  imports = [
    ./git
    ./colorls
    ./kitty
    ./iterm2
    ./zsh
  ];

  ##### interface

  options = {
    modules.cli.enable = mkEnableOption "Enable home-manager configuration of user shells.";
  };

  ##### implementation

  config = mkIf cfg.enable {

    # Direnv configuration
    programs.direnv = {
      enable = true;
      enableZshIntegration = cfg.zsh.enable;
      config.global.warn_timeout = "1m";
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };

    programs.command-not-found.enable = true;

  };
}
