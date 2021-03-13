{config, pkgs, lib, shared, ...}: {
let
  inherit (shared.network) domain;
in
{
  imports = [ ../nginx/reverse-proxy.nix ];

  modules.services.valheim-server = {
    enable = true;
    serverName = "Foxheim";
    port = 2456;
    world = "Dedicated";
    password = "dontbeevil";
  };

  networking.firewall.allowedUDPPortRanges = [
    {
      from = 2456;
      to = 2458;
    }
  ];

  services.nginx.virtualHosts."valheim.${domain}" = {
    #useACMEHost = domain;
    #forceSSL = true;
    locations = {
      "/" = {
        proxyPass = "http://localhost";
      };
    };
  };

}
