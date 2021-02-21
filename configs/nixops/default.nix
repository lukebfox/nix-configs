{ pkgs, shared, secrets, ... }:
{

  network.description = shared.network.domain;

  webserver =
    { ... }:
    {
      imports = [
        ../../profiles/nixops/backends/hetznercloud-small.nix
        ../../profiles/nixos/services/bitwarden
        ../../profiles/nixos/services/blog
      ];
    };

}
