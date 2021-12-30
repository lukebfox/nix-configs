{ ... }:
{
  # Weekly fstrim for SSD.
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";
}
