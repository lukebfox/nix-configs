{ config, shared, ... }:
let
  inherit (shared.network) domain;
in
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Nginx as http server here. dont encrypt, let proxy handle all that.
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts.${domain} = {
      #locations."/resume/" = {
      #  alias = config.nixpkgs.pkgs.cv + "/";
      #  index = "cv.pdf";
      #};
      locations."/".root = config.nixpkgs.pkgs.blog;
      extraConfig = "error_page 404 /404.html;";
    };
  };
}
