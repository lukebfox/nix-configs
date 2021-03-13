{config, pkgs, lib, ...}:
let
  inherit (lib) fileContents;
in
{
  modules.services.valheim-server = {
    enable = true;
    serverName = "Foxheim";
    port = 2456;
    worldName = "Dedicated";
    password = fileContents ../../../../data/secret/valheim-password; # unsafe-secret
  };
}
