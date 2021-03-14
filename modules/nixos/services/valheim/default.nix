{ config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkMerge mkOption mkEnableOption types;

  cfg = config.modules.services.valheim;

  updateCmd = ''${pkgs.steamcmd}/bin/steamcmd \
                  +login anonymous \
                  +force_install_dir $STATE_DIRECTORY \
                  +app_update 896660 \
                  +quit'';

  startCmd  = ''${pkgs.glibc}/lib/ld-linux-x86-64.so.2 ./valheim_server.x86_64 \
                  -name "${cfg.serverName}" \
                  -port ${toString cfg.port} \
                  -world "${cfg.worldName}" \
                  -password "${cfg.password}" \
                  -public 1'';
in
{
  ##### interface

  options = {

    modules.services.valheim.enable = mkEnableOption "Enable valheim-server nixos module";

    modules.services.valheim.serverName = mkOption {
      type = types.str;
      example = "ValheimRocks";
      description = "Name of the valheim server.";
    };

    modules.services.valheim.worldName = mkOption {
      type = types.str;
      example = "MyFirstWorld";
      description = "Name of the valheim world.";
    };

    modules.services.valheim.password = mkOption {
      type = types.str;
      description = "Password used to authenticate to the server.";
    };

    modules.services.valheim.port = mkOption {
      type = types.int;
      description = "Port on which valheim server listens for connections.";
    };

  };

  ##### implementation

  config = mkIf cfg.enable {

    users.users.valheim.home = "/var/lib/valheim";

    systemd.services.valheim = {
      # linux64 directory is required by Valheim.
      environment.LD_LIBRARY_PATH = "linux64:${pkgs.glibc}/lib";
      serviceConfig = {
        User = "valheim";
        ExecStartPre = updateCmd;
        ExecStart = startCmd;
        Nice = "-5";
        Restart = "always";
        StateDirectory = "valheim";
        WorkingDirectory = "/var/lib/valheim";
      };
      wantedBy = [ "multi-user.target" ];
    };

    systemd.services.update-valheim = {
      serviceConfig = {
        Type = "oneshot";
        User = "valheim";
        StateDirectory = "valheim";
        WorkingDirectory = "/var/lib/valheim";
      };
      script = ''
        OUTPUT="$(${updateCmd} | tail -n 1)"
        SUCCESS="Success! App '896660' already up to date."
        if ![[ $OUTPUT == $SUCCESS ]]; then
            echo "Restarting valheim"
            systemctl restart valheim.service
        fi
      '';
      wantedBy = [ "multi-user.target" ];
    };

    systemd.timers.update-valheim = {
      partOf = [ "update-valheim.service" ];
      timerConfig.OnCalendar = "*-*-* 8:00:00";
      wantedBy = [ "timers.target" ];
    };

  };

}
