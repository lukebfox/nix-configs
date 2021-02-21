{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.programs.emacs;
in
{
  ##### interface

  options.modules.programs.emacs.enable = mkEnableOption "Enable home-manager module for emacs.";

  ##### implementation

  config = mkIf cfg.enable {


    # Emacsclient based workflow.

    programs.emacs = {
      enable = true;
      package = pkgs.emacsUnstable;
    };

    services.emacs = {
      enable = true;
      client.enable = true;
      client.arguments = [ "-n" "-c" ];
      socketActivation.enable = true;
    };

    home.sessionVariables = {
      VISUAL = "emacsclient";    # open file in an existing frame
      EDITOR = "emacsclient -t"; # connect to server in tty
    };

    home.packages = [
      pkgs.multimarkdown
      pkgs.fira-code
      pkgs.sqlite # required for org-roam
    ];

    fonts.fontconfig.enable = true;

  };

}
