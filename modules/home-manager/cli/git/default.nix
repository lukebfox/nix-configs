{ config, lib, ... } @ args:
let
  inherit (lib) mkIf mkEnableOption mkOption types;

  cfg = config.modules.cli.git;
in
{

  ##### interface

  options = {
    modules.cli.git.enable = mkEnableOption "Enable home-manager module for git.";

    modules.cli.git.userName = mkOption {
      example = "lukebfox";
      type = types.str;
      description = ''
        The GitHub username of this user.
      '';
    };

    modules.cli.git.userEmail = mkOption {
      example = "example@gmail.com";
      type = types.str;
      description = ''
        The email address this user used to register with GitHub.
      '';
    };

    modules.cli.git.signingKey = mkOption {
      example = "example@gmail.com";
      type = types.str;
      description = ''
        The email record of the UID for the GPG key that this user uses to sign
        their commits.
      '';
    };
  };

  ##### implementation

  config = mkIf cfg.enable {
    programs.git = {
      inherit (cfg) userName userEmail;
      enable = true;
      aliases = {
        graph = "log --graph --date=short --pretty='%C(auto)%h %C(auto,blue)%ad%Creset%C(auto)%d %s - %C(auto,blue)%ae'";
        tree  = "log --graph --date=short --pretty='%C(auto)%h %C(auto,blue)%ad%Creset%C(auto)%d %s - %C(auto,blue)%ae' --all";
        find-merge = "!sh -c 'commit=$0 && branch=\${1:-HEAD} && (git rev-list $commit..$branch --ancestry-path | cat -n; git rev-list $commit..$branch --first-parent | cat -n) | sort -k2 -s | uniq -f1 -d | sort -n | tail -1 | cut -f2'";
        show-merge = "!sh -c 'merge=$(git find-merge $0 $1) && [ -n \"$merge\" ] && git show $merge'";
      };
      delta.enable = true;
      ignores = ["*.swp" "~*"];
      signing.signByDefault = true;
      signing.key = cfg.signingKey;
      extraConfig = {
        core.whitespace = "trailing-space";
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
        pull.rebase = true;
        rebase.autostash = true;
      };
    };
  };
}
