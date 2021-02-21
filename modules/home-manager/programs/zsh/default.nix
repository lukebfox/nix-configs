{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues readFile;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.programs.zsh;
in
{
  ##### interface

  options.modules.programs.zsh.enable = mkEnableOption "Enable home-manager module for zsh.";

  ##### implementation

  config = mkIf cfg.enable {

    home.packages = attrValues {
      inherit (pkgs)
        # zsh-syntax-highlighting
        # zsh-completions
        bzip2
        gzip
        lrzip
        p7zip
        procs
        unrar
        unzip;
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      dotDir = ".config/zsh";
      history.path = ".cache/zsh/zsh_history";
      sessionVariables.KEYTIMEOUT = 1; # https://www.johnhawthorn.com/2012/09/vi-escape-delays/
      shellAliases = {
        bat = "${pkgs.bat}/bin/bat --theme base16";
        fastping = "ping -c 100 -i .2";
        ls  = "${pkgs.colorls}/bin/colorls";
        ll  = "${pkgs.colorls}/bin/colorls -Al --sd";
        lt  = "${pkgs.colorls}/bin/colorls -A --sd --tree=2";
        lt3 = "${pkgs.colorls}/bin/colorls -A --sd --tree=3";
        myip ="${pkgs.curl}/bin/curl http://ipecho.net/plain; echo";
        ngco = "sudo nix-collect-garbage --delete-old";
        nrs  = "sudo nixos-rebuild switch";
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
        # autosuggestions.color = "";
        caseSensitive = false;
        completions.ignoredHosts = [ "0.0.0.0" "127.0.0.1" ];
        editor.dotExpansion = true;
        editor.keymap = if config.modules.programs.emacs.enable then "emacs" else "vi";
        # extraConfig = {};
        # extraFunctions = {};
        # extraModules = {};
        git.submoduleIgnore = null;
        # historySubString.globbingFlags = "";
        # historySubstring.foundColor = "fg=red";
        # historySubstring.notFoundColor = "fg=green";
        # pmoduleDirs = [];
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          # "history-substring-search"
          "directory"
          "spectrum"
          "utility"
          "git"
          "completion"
          "syntax-highlighting"
          # "contrib-prompt"
          "prompt"
          "ssh"
        ];
        ssh.identities = [ "id_ed25519" "yubikey" ];
        syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "root" ];
        syntaxHighlighting.pattern = {
          "rm*-rf*"           = "fg=white,bold,bg=red";
          "dd*if=/*of=/dev/*" = "fg=white,bold,bg=red";
        };
        syntaxHighlighting.styles = {
          builtin  = "fg=yellow";
          command  = "fg=green";
          function = "fg=blue";
        };
        terminal.autoTitle = true;
        terminal.windowTitleFormat = "%n@%m: %s";
      };
    };

    programs.starship = {
      enable = true;
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

  };
}
