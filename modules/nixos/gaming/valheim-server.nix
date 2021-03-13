{ config, lib, pkgs, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkMerge mkOption mkEnableOption types;

  cfg = config.modules.services.valheim-server;
in
{
  options = {
    modules.services.valheim-server.enable = mkEnableOption "Enable valheim-server nixos module";

    modules.services.valheim-server.serverName = mkOption {
      type = types.str;
      example = "ValheimRocks";
      description = "Name of the valheim server.";
    };

    modules.services.valheim-server.worldName = mkOption {
      type = types.str;
      example = "MyFirstWorld";
      description = "Name of the valheim world.";
    };

    modules.services.valheim-server.password = mkOption {
      type = types.str;
      description = "Optional password used to authenticate to the server.";
    };

    modules.services.valheim-server.port = mkOption {
      type = types.int;
      description = "Port on which valheim server listens for connections.";
    };

  };
  config = mkIf cfg.enable {

    users.users.valheim = {
      home = "/var/lib/valheim";
    };

    systemd.services.valheim = {
      environment = {
        # linux64 directory is required by Valheim.
        LD_LIBRARY_PATH = "linux64:${pkgs.glibc}/lib";
      };
      serviceConfig = {
        User = "valheim";
        ExecStartPre = ''
          ${pkgs.steamcmd}/bin/steamcmd \
            +login anonymous \
            +force_install_dir $STATE_DIRECTORY \
            +app_update 896660 \
            +quit
        '';
        ExecStart = ''
          ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 ./valheim_server.x86_64 \
            -name "${cfg.serverName}" \
            -port ${toString cfg.port} \
            -world "${cfg.worldName}" \
            -password "${cfg.password}" \
            -public 1
        '';
        Nice = "-5";
        Restart = "always";
        StateDirectory = "valheim";
        WorkingDirectory = "/var/lib/valheim";
      };
      wantedBy = [ "multi-user.target" ];
    };

  };
}
