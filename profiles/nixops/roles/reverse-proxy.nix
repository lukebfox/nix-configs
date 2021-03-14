{ config, pkgs, shared, nodes, resources, ... }:
let
  inherit (shared.network) domain;
  inherit (pkgs) runCommand;

  dmzIP = node:
    let
      dmzServerNetwork =
        builtins.elemAt
          node.config.deployment.hetznerCloud.serverNetworks
          0;
    in dmzServerNetwork.privateIP;
in
{
  imports = [ ../../nixos/services/acme/dns-challenge.nix ];

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 2456 2457 2458 ];
  };

  # Nginx TLS reverse proxy
  services.nginx = {
    enable = true;
    package = pkgs.nginxMainline;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      # Blog visible at the root domain
      ${domain} = {
        useACMEHost = domain;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${dmzIP nodes.webserver}:80";
        };
      };
      # Password manager at subdomain
      "bitwarden.${domain}" = {
        useACMEHost = domain;
        forceSSL = true;
        locations = {
          "/" = {
            proxyPass = "http://${dmzIP nodes.webserver}:8812";
            proxyWebsockets = true;
          };
          "/notifications/hub" = {
            proxyPass = "http://${dmzIP nodes.webserver}:3012";
            proxyWebsockets = true;
          };
          "/notifications/hub/negotiate" = {
            proxyPass = "http://${dmzIP nodes.webserver}:8812";
            proxyWebsockets = true;
          };
        };
      };
      # Wildcard DNS will match all subdomains even non-existing ones,
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
    # Forward udp traffic on certain ports to game server.
    streamConfig = ''
        server {
            listen 2456 udp;
            listen 2567 udp;
            listen 2558 udp;
            proxy_pass ${dmzIP nodes.valheim-server}:2456;
        }
    '';
  };

  # Let Nginx access certificates managed by ACME.
  users.groups.acme.members = ["nginx"];
}
