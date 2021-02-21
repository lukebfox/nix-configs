{ config, pkgs, shared, ... }:
let
  inherit (shared.network) domain;
  inherit (pkgs) runCommand;
in
{
  imports = [ ../acme/dns-challenge.nix ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Nginx TLS reverse proxy
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # Wildcard DNS will send requests to any subdomains through,
    # so fallback to 404 if no other virtualHosts gets matched.
    virtualHosts."*.${domain}" = {
      useACMEHost = domain;
      forceSSL = true;
      root = runCommand "404" {} ''
        mkdir "$out"
        echo 404 not found > "$out/index.html"
      '';
    };
  };

  # Let Nginx access certificates managed by ACME.
  users.groups.acme.members = ["nginx"];
}
