{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.zsh;
in
{
  ##### interface

  options = {
    modules.cli.zsh.enable = mkEnableOption "Enable home-manager module for zsh.";
  };

  ##### implementation

  config = mkIf cfg.enable {

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      history.extended = true;
      initExtra = ''
      function nbhm () nix build ".#homeManagerConfigurations.$1.activationPackage" && ./result/activate;
      '';
      sessionVariables.KEYTIMEOUT = 1; # https://www.johnhawthorn.com/2012/09/vi-escape-delays/
      shellAliases = {
        fastping = "ping -c 100 -i .2";
        ls  = "${pkgs.colorls}/bin/colorls";
        ll  = "${pkgs.colorls}/bin/colorls -Al --sd";
        lt2  = "${pkgs.colorls}/bin/colorls -A --sd --tree=2";
        lt3 = "${pkgs.colorls}/bin/colorls -A --sd --tree=3";
        myip = "${pkgs.curl}/bin/curl http://ipecho.net/plain; echo";
        ngco = "sudo nix-collect-garbage --delete-old";
        nrs  = "sudo nixos-rebuild switch";
        nixfix = "nix-store --verify --check-contents --repair";
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
          highlighters = [ "main" "brackets" "pattern" "cursor" "root" ];
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
  };

}
