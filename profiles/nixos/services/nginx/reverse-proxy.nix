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
    virtualHosts = {

      # Block for my website.
      ${domain} = {
        useACMEHost = domain;
        forceSSL = true;
        locations."/" = {
          proxyPass = "https://localhost:80";
        };
      };

      # Block for password manager service.
      "bitwarden.${domain}" = {
        useACMEHost = domain;
        forceSSL = true;
        locations = {
          "/" = {
            proxyPass = "http://localhost:8812";
            proxyWebsockets = true;
          };
          "/notifications/hub" = {
            proxyPass = "http://localhost:3012";
            proxyWebsockets = true;
          };
          "/notifications/hub/negotiate" = {
            proxyPass = "http://localhost:8812";
            proxyWebsockets = true;
          };
        };
      };

      # Wildcard DNS will send requests to any subdomains through,
      # so fallback to 404 if no other virtualHosts gets matched.
      "*.${domain}" = {
        useACMEHost = domain;
        forceSSL = true;
        root = runCommand "404" {} ''
          mkdir "$out"
          echo 404 not found > "$out/index.html"
        '';
      };
    };
  };

  # Let Nginx access certificates managed by ACME.
  users.groups.acme.members = ["nginx"];
}
