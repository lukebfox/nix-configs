{ pkgs, shared, ... }:
let
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
in
{

  network.description = domain;
  network.storage.legacy.databasefile = ../../data/secret/localstate.nixops;

  resources.hetznerCloudNetworks.dmz = {
    inherit apiToken;
    ipRange = "10.10.0.0/16";
    subnets = [ "10.10.10.0/24" ];
  };

  resources.hetznerCloudFloatingIPs.fip1 = { inherit apiToken; location = "nbg1"; };
  #resources.hetznerCloudVolumes.vol1 = { inherit apiToken; location = "nbg1"; };

  bastion =
    { resources, ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/cx11.nix
        (dmzServerNetworkProfile 10)
        ../../profiles/nixops/roles/reverse-proxy.nix
        ../../profiles/nixos/hardened
      ];
      deployment.hetznerCloud.ipAddresses = [ resources.hetznerCloudFloatingIPs.fip1 ];
    };


  homeserver =
    { ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/cx11.nix
        (dmzServerNetworkProfile 20)
        ../../profiles/nixos/services/bitwarden
        ../../profiles/nixos/services/blog
      ];
    };

}
