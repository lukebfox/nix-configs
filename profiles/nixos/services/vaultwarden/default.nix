{ config, lib, pkgs, shared, ... }:
let
  inherit (shared.network) domain;
in
{
  imports = [ ../acme/dns-challenge.nix ];

  networking.firewall.allowedTCPPorts = [ 3012 8812 ];

  # Bitwarden server
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://${domain}";
      
      LOG_FILE = "/var/log/vaultwarden";

      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8812;
      ROCKET_LOG = "info";
      
      WEBSOCKET_ENABLED= true;
      WEBSOCKET_ADDRESS = "0.0.0.0";
      WEBSOCKET_PORT = 3012;
      
      WEB_VAULT_FOLDER = "${pkgs.vaultwarden-vault}/share/vaultwarden/vault";
      WEB_VAULT_ENABLED = true;
    };
  };

  environment.systemPackages = [ pkgs.vaultwarden-vault ];

  # Let Bitwarden access the wildcard SSL certificates managed by ACME.
  users.groups.acme.members = ["vaultwarden"];
}
