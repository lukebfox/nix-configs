{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.syncthing ];
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # gui defaults to 8384
  };
}
