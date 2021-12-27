{ pkgs,  ... }:
{
  environment.systemPackages = [ pkgs.razergenie ];
  hardware.openrazer = {
    enable = true;
    keyStatistics = true;
    devicesOffOnScreensaver = false;
  };
}
