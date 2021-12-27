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
    #backupDir = "/mnt/bitwarden";
    config = {
      WEB_VAULT_FOLDER = "${pkgs.vaultwarden-vault}/share/vaultwarden/vault";
      WEB_VAULT_ENABLED = true;
      LOG_FILE = "/var/log/vaultwarden";
      WEBSOCKET_ENABLED= true;
      WEBSOCKET_ADDRESS = "0.0.0.0";
      WEBSOCKET_PORT = 3012;
      DOMAIN = "https://${domain}";
      ROCKET_PORT = 8812;
    };
  };

  environment.systemPackages = [ pkgs.vaultwarden-vault ];

  # Let Bitwarden access the wildcard SSL certificates managed by ACME.
  users.groups.acme.members = ["vaultwarden"];
}
