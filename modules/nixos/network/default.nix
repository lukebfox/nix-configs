{ config, lib, pkgs, utilities, ... }:

let
  inherit (builtins) readDir;
  inherit (lib) mapAttrs mkIf mkEnableOption mkOption mkMerge recursiveUpdate types;

  cfg = config.modules.network;
in
{

  ##### interface

  options = {
    modules.network.enable           = mkEnableOption "Enable system module for networking.";
    modules.network.bluetooth.enable = mkEnableOption "Enable bluetooth management via bluetoothctl.";
    modules.network.wifi.enable      = mkEnableOption "Enable network management via networkmanager.";
  };

  ##### implementation

  config = mkIf cfg.enable (mkMerge [

    {
      programs.mtr.enable = true;
    }

    (mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;
    })

    (mkIf cfg.wifi.enable {

      environment.systemPackages = [ pkgs.wirelesstools ];

      networking = {
        enableIPv6 = false;
        firewall.enable = false;

        # Network Manager
        networkmanager = {
          enable = true;
          wifi.macAddress = "preserve";
          wifi.powersave = true;
        };
      };

      # Handle sensitive network manager configurations.
      modules.secrets =
        let
          connectionsDir = ../../../data/secret/nmconnections;
        in
          mapAttrs
            (n: v: {
              source = connectionsDir + "/${n}";
              dest = "/etc/NetworkManager/system-connections/${n}";
              permissions = "0600";
            })
            (readDir connectionsDir);
    })

  ]);
}
