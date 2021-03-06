# marking as broken
{ config, lib, pkgs, shared, ... }:
let
  inherit (shared.network) domain;
in
{
  imports = [ ../nginx/reverse-proxy.nix ];

  services.matrix-synapse = {
    enable = true;
    server_name = domain;
    # unsafe secret
    registration_shared_secret = lib.fileContents ../../../../data/secret/synapse-registration-secret;
    listeners = [
      {
        port = 8008;
        bind_address = "::1";
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [
          {
            names = [ "client" "federation" ];
            compress = false;
          }
        ];
      }
    ];
  };

  # Configure the postgreSQL database.
  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "synapse-init.sql" ''
      CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
      CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
        TEMPLATE template0
        LC_COLLATE = "C"
        LC_CTYPE = "C";
    '';
  };

  # Nginx well_known entries.
  services.nginx.virtualHosts."${domain}" = {
    locations."= /.well-known/matrix/server".extraConfig =
      let
        # use 443 instead of the default 8448 port to unite
        # the client-server and server-server port for simplicity
        server = { "m.server" = "matrix.${domain}:443"; };
      in ''
        add_header Content-Type application/json;
        return 200 '${builtins.toJSON server}';
      '';
    locations."= /.well-known/matrix/client".extraConfig =
      let
        client = {
          "m.homeserver" =  { "base_url" = "https://matrix.${domain}"; };
          "m.identity_server" =  { "base_url" = "https://vector.im"; };
        };
        # ACAO required to allow element-web on any URL to request this json file
      in ''
        add_header Content-Type application/json;
        add_header Access-Control-Allow-Origin *;
        return 200 '${builtins.toJSON client}';
      '';
  };

  # Reverse proxy for Matrix client-server and server-server communication
  services.nginx.virtualHosts."matrix.${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    # Or do a redirect instead of the 404, or whatever is appropriate for you.
    # But do not put a Matrix Web client here! See the Element web section below.
    locations."/".extraConfig = ''
      return 404;
    '';
    # forward all Matrix API calls to the synapse Matrix homeserver
    locations."/_matrix" = {
      proxyPass = "http://[::1]:8008"; # without a trailing /
    };
  };

  # Let Synapse access the wildcard SSL certificates managed by ACME.
  users.groups.acme.members = ["matrix-synapse"];

}
