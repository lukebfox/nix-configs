{ config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues readFile;
  inherit (lib) mkEnableOption mkIf mkMerge;

  cfg = config.modules.shell;
in
{
  ##### interface

  options = {
    modules.shell.enable = mkEnableOption "Enable home-manager configuration of user shells.";
    modules.shell.zsh.enable = mkEnableOption "Enable home-manager module for zsh.";
  };

  ##### implementation

  config = mkIf cfg.enable (mkMerge [

    {
      # Direnv configuration
      programs.direnv = {
        enable = true;
        enableNixDirenvIntegration = true;
        config.global.warn_timeout = "1m";
      };
    }

    (mkIf cfg.bash.enable {})

    (mkIf cfg.zsh.enable {
      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        autocd = true;
        sessionVariables.KEYTIMEOUT = 1; # https://www.johnhawthorn.com/2012/09/vi-escape-delays/
        shellAliases = {
          fastping = "ping -c 100 -i .2";
          ls  = "${pkgs.colorls}/bin/colorls";
          ll  = "${pkgs.colorls}/bin/colorls -Al --sd";
          lt  = "${pkgs.colorls}/bin/colorls -A --sd --tree=2";
          lt3 = "${pkgs.colorls}/bin/colorls -A --sd --tree=3";
          myip = "${pkgs.curl}/bin/curl http://ipecho.net/plain; echo";
          ngco = "sudo nix-collect-garbage --delete-old";
          nrs  = "sudo nixos-rebuild switch";
          nbhm = "nix build '.#homeManagerConfigurations.luminance.activationPackage' && ./result/activate;"; #FIXME generic
          j    = "ssh jump -t luminance-jumpcli ssh";
        };
        shellGlobalAliases = {
          C="| wc -l";
          H="| head";
          L="| less";
          N="| /dev/null";
          S="| sort";
          G="| rg";
        };
        prezto = {
          enable = true;
          caseSensitive = false;
          pmodules = [
            "environment"
            "terminal"
            "editor"
            "history"
            "directory"
            "spectrum"
            "utility"
            "git"
            "completion"
            "syntax-highlighting"
            "contrib-prompt"
            "prompt"
            "ssh"
          ];
          terminal = {
            autoTitle = true;
            windowTitleFormat = "%n@%m: %s";
          };
          editor = {
            dotExpansion = true;
            keymap = if config.modules.editor.emacs.enable then "emacs" else "vi";
          };
          git = {
            submoduleIgnore = null;
          };
          completions = {
            ignoredHosts = [ "0.0.0.0" "127.0.0.1" ];
          };
          syntaxHighlighting = {
            highlighters = ["main" "brackets" "pattern" "cursor" "root" ];
            pattern = {
              "rm*-rf*"           = "fg=white,bold,bg=red";
              "dd*if=/*of=/dev/*" = "fg=white,bold,bg=red";
            };
            styles = {
              builtin  = "fg=yellow";
              command  = "fg=green";
              function = "fg=blue";
            };
          };
          prompt = {
            theme = "spaceship";
          };
          ssh = {
            identities = [ "id_rsa" "id_ed25519" "yubikey" ];
          };
        };
      };

      programs.starship = {
        enable = false;
        settings = {
          add_newline = false;
          format = "$all";
          # format = "$line_break$directory$nix_shell$package$line_break$character";
          scan_timeout = 10;
          character.success_symbol = "[λ](bold green)";
          character.error_symbol = "[λ](bold red)";
          directory.fish_style_pwd_dir_length = 1;
          nix_shell.format = "via [❄ $state \($name\) ](bold blue)";
        };
      };
    })
  ]);
}
