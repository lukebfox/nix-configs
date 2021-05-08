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
        privateIP = "10.10.10.${toString id}";
      }];
    };
in
{

  network.description = domain;

  resources.hetznerCloudNetworks.dmz = {
    inherit apiToken;
    ipRange = "10.10.0.0/16";
    subnets = ["10.10.10.0/24"];
  };

  bastion =
    { ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/small.nix
        (dmzServerNetworkProfile 10)
        ../../profiles/nixops/roles/reverse-proxy.nix
        ../../profiles/nixos/hardened
      ];
    };

  webserver =
    { ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/small.nix
        (dmzServerNetworkProfile 11)
        ../../profiles/nixos/services/bitwarden
        ../../profiles/nixos/services/blog
      ];
    };

  valheim-server =
    { ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud/medium.nix
        (dmzServerNetworkProfile 20)
        ../../profiles/nixos/services/valheim
        ../../profiles/nixos/users/rokas.bagdonas
      ];
    };

}
