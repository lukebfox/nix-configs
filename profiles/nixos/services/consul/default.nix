# TODO
{ ... }:
{
  services.consul = {
    enable = true;
    webUi  = true;
    server = true;
    extraConfig = ''
    '';
  };
}
