{config, pkgs, lib, ...}:
let
  inherit (lib) fileContents;
in
{
  networking.firewall.allowedUDPPorts = [ 2456 2457 2458 ];

  modules.services.valheim-server = {
    enable = true;
    serverName = "Foxheim";
    port = 2456;
    worldName = "Zania";
    password = fileContents ../../../../data/secret/valheim-password; # unsafe-secret
  };
}
