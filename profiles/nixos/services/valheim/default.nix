{ lib, ... }:
let
  inherit (lib) fileContents;
in
{
  networking.firewall.allowedUDPPorts = [ 2456 2457 2458 ];

  modules.services.valheim = {
    enable = true;
    serverName = "Foxheim";
    port = 2456;
    worldName = "Zania";
    # Stored in nix store
    password = fileContents ../../../../data/secret/valheim-password;
  };
}
