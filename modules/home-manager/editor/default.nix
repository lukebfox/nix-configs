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

    # base config for all editors
    {

    }

    (mkIf cfg.emacs.enable {

      programs.emacs = {
        enable = true;
        package = pkgs.emacsUnstable;
      };

      # Emacsclient based workflow.
      services.emacs = {
        enable = true;
        client.enable = true;
        client.arguments = [ "-n" "-c" ];
        socketActivation.enable = true;
      };

      fonts.fontconfig.enable = true;

      home.sessionVariables = mkIf (!config.modules.standalone.enable) {
        VISUAL = "emacsclient";    # open file in an existing frame
        EDITOR = "emacsclient -t"; # connect to server in tty
      };

      home.packages = [
        pkgs.multimarkdown
        pkgs.fira-code
        pkgs.emacs-all-the-icons-fonts
        pkgs.sqlite   # required for org-roam
        pkgs.graphviz # required for org-roam
      ];

      # Installing doom in this way is impure, but doom itself uses straight.el 
      # for managing its own dependences purely.
      # FIXME
      # Currently this diffs a directory `.doom.d` which always returns true,
      # wasting time recopying needlessly
      home.file.".doom.d" = {
        source = toString ./doom-emacs;
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
