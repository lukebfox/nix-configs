{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;

  cfg = config.modules.editor;

in
{
  ##### interface

  options = {
    modules.editor.enable = mkEnableOption "Enable home-manager editor module.";
    modules.editor.emacs.enable = mkEnableOption "Enable home-manager module for emacs.";
  };

  ##### implementation

  config = mkIf cfg.enable (mkMerge [

    {

    }

    (mkIf cfg.emacs.enable {

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

      fonts.fontconfig.enable = true;

      home.sessionVariables = {
        VISUAL = "emacsclient";    # open file in an existing frame
        EDITOR = "emacsclient -t"; # connect to server in tty
      };

      home.packages = [
        pkgs.multimarkdown
        pkgs.fira-code
        pkgs.emacs-all-the-icons-fonts
        pkgs.sqlite # required for org-roam
      ];

      home.file.".doom.d" = {
        source = toString ./.doom.d;
        recursive = true;
        onChange = ''
          #!/usr/bin/env sh
          DOOM="$HOME/.emacs.d"

          if [ ! -d "$DOOM" ]; then
              git clone --depth 1 https://github.com/hlissner/doom-emacs.git $DOOM
              $DOOM/bin/doom -y install
          fi
          $DOOM/bin/doom sync
        '';
      };
    })

  ]);
}
