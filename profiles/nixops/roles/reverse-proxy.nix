{ config, pkgs, shared, nodes, resources, ... }:
let
  inherit (shared.network) domain;
  inherit (pkgs) runCommand;
in
{
  imports = [ ../../nixos/services/acme/dns-challenge.nix ];

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
  };

  # Nginx TLS reverse proxy
  services.nginx = {
    enable = true;
    package = pkgs.nginxStable.override { openssl = pkgs.libressl; };
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      # Blog visible at the root domain
      ${domain} = {
        useACMEHost = domain;
        forceSSL = true;
      };
      # Password manager at subdomain
      "vaultwarden.${domain}" = {
        useACMEHost = domain;
        forceSSL = true;
      };
      # Wildcard DNS will match all subdomains even non-existing ones,
      # so fallback to 404 if no other virtualHosts gets matched.
      "*.${domain}" = {
        useACMEHost = domain;
        forceSSL = true;
        root = runCommand "404" { } ''
          mkdir "$out"
          cp ${pkgs.blog}/404.html $out/index.html
        '';
      };
    };
  };

  # Let Nginx access certificates managed by ACME.
  users.groups.acme.members = [ "nginx" ];
}
