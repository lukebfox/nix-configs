{ config, shared, ... }:
let
  inherit (shared.network) domain;
in
{
  imports = [ ../nginx/reverse-proxy.nix ];

  # Nginx as https server here.
  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations."/resume/" = {
      alias = config.nixpkgs.pkgs.cv + "/";
      index = "cv.pdf";
    };
    locations."/".root = config.nixpkgs.pkgs.blog;
    extraConfig = "error_page 404 /404.html;";
  };

}
