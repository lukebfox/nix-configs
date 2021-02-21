{ config, shared, ... }:
let
  inherit (shared) domain;
in
{
  imports = [ ../nginx/reverse-proxy.nix ];

  # IceCast2 stream broadcaster
  services.icecast = {
    enable = true;
    admin.user = "admin";
    admin.password = "password";
    hostname = config.networking.hostName;
    listen.port = 8010;
    listen.address = "0.0.0.0";
    extraConf = ''
    <authentication>
      <source-password>hackme</source-password>
      <relay-password>hackme</relay-password>
      <admin-user>admin</admin-user>
      <admin-password>hackme</admin-password>
    </authentication>
    <limits>
      <sources>5</sources>
      <burst-on-connect>1</burst-on-connect>
      <burst-size>65536</burst-size>
    </limits>
    '';
  };

  services.nginx.virtualHosts."music.${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations = {
      "/icecast" = {
        proxyPass = "http://localhost:8010";
        proxyWebsockets = true;
      };
    };
  };

}
