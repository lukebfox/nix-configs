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
  imports = [ ../nixos/services/acme/dns-challenge.nix ];

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPortRanges = [{ # valheim
      from = 2456;
      to = 2458;
    }];
  };

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
          proxyPass = "http://${dmzIP nodes.webserver}:80";
        };
      };

      # Block for password manager service.
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

      "valheim.${domain}".locations."/" = {
        proxyPass = "http://${dmzIP nodes.valheim-server}";
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
