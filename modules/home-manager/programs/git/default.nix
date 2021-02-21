{ nixosConfig, config, lib, pkgs, ... } @ args:
let
  inherit (lib) mkIf mkEnableOption mkOption types;

  cfg = config.modules.programs.git;
in
{

  ##### interface

  options = {
    modules.programs.git.enable = mkEnableOption "Enable home-manager module for git.";

    modules.programs.git.userName = mkOption {
      example = "lukebfox";
      type = types.str;
      description = ''
        The GitHub username of this user.
      '';
    };

    modules.programs.git.userEmail = mkOption {
      example = "example@gmail.com";
      type = types.str;
      description = ''
        The email address this user used to register with GitHub.
      '';
    };
    modules.programs.git.signingKey = mkOption {
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
      delta.enable = true;
      ignores = ["*.swp" "~*"];
      signing.signByDefault = true;
      signing.key = cfg.signingKey;
      extraConfig = {
        core.whitespace = "trailing-space";
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
      };
    };
  };
}
