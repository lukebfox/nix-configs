{ pkgs, shared, ... }:
let
  inherit (builtins) elemAt;
  inherit (shared.network) domain;
  inherit (pkgs.lib) fileContents;

  apiToken = fileContents ../../data/secret/hetznercloud-api-token;

  dmzServerNetworkProfile = id:
    { resources, ... }:
    {
      deployment.hetznerCloud.serverNetworks = [{
        network = resources.hetznerCloudNetworks.dmz;
        privateIpAddress = "10.10.10.${toString id}";
      }];
    };
  dmzIP = node:
    let
      dmzServerNetwork = elemAt node.config.deployment.hetznerCloud.serverNetworks 0;
    in
    dmzServerNetwork.privateIpAddress;
in
{

  network.description = domain;
  network.storage.legacy.databasefile = ../../data/secret/localstate.nixops;

  resources.hetznerCloudNetworks.dmz = {
    inherit apiToken;
    ipRange = "10.10.0.0/16";
    subnets = [ "10.10.10.0/24" ];
  };

  bastion =
    { nodes, resources, ... }:
    let
     inherit (nodes.manwe.config.services.vaultwarden.config) ROCKET_PORT WEBSOCKET_PORT;
     baseurl = "http://${dmzIP nodes.manwe}";
    in
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/cx11.nix
        (dmzServerNetworkProfile 2)
        ../../profiles/nixops/roles/reverse-proxy.nix
        ../../profiles/nixos/hardened
      ];
      deployment.hetznerCloud.ipAddresses = [ "lukebentleyfox-net" ];
      services.nginx.virtualHosts = {
        ${domain}.locations."/" = {
          proxyPass = "${baseurl}:80";
        };
        "vaultwarden.${domain}".locations = {
          "/" = {
            proxyPass = "${baseurl}:${toString ROCKET_PORT}";
            proxyWebsockets = true;
          };
          "/notifications/hub" = {
            proxyPass = "${baseurl}:${toString WEBSOCKET_PORT}";
            proxyWebsockets = true;
          };
          "/notifications/hub/negotiate" = {
            proxyPass = "${baseurl}:${toString ROCKET_PORT}";
            proxyWebsockets = true;
          };
        };
      };
    };

  manwe =
    { ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/cx11.nix
        (dmzServerNetworkProfile 10)
        ../../profiles/nixos/services/vaultwarden
        ../../profiles/nixos/services/blog
      ];
    };

}
