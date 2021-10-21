{ pkgs, ... }:
let
  inherit (builtins) attrValues;
in
{

  modules = {
    network.enable = true;
    network.bluetooth.enable = true;
    network.wifi.enable = true;
  };

  # Useful packages
  environment.systemPackages = attrValues {
    inherit (pkgs)
      lsof       # list files files opened by processes
      acpi       # /proc querier
      lm_sensors # hardware health monitor
      pciutils;  # `lspci` and `setpci`
  };

  # Location provider.
  location.provider = "geoclue2";

  # Audio support.
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  # to enable brightness keys 'keys' value may need updating per device
  #services.actkbd = {
  #  enable = true;
  #  bindings = [
  #    {
  #      keys = [ 225 ];
  #      events = [ "key" ];
  #      command = "/run/current-system/sw/bin/light -A 5";
  #    }
  #    {
  #      keys = [ 224 ];
  #      events = [ "key" ];
  #      command = "/run/current-system/sw/bin/light -U 5";
  #    }
  #  ];
  #};

  # REVIEW does this interfere with any window manager configuration?
  sound.mediaKeys = {
    enable = true;
    volumeStep = "1dB";
  };

  # Better NTP timesync for unstable internet connections.
  services.timesyncd.enable = false;
  services.chrony.enable = true;

  # Weekly fstrim for SSD.
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  # REVIEW how does this fit in with gdm and awesomeWM
  services.logind.lidSwitch = "suspend";

  # CUPS printing.
  services.printing.enable = true;

  # Power management features.
  services.tlp.enable = false;
  services.tlp.settings = {
    "CPU_SCALING_GOVERNOR_ON_AC" = "performance";
    "CPU_SCALING_GOVERNOR_ON_BAT" = "powersave";
    "CPU_HWP_ON_AC" = "performance";
    "MAX_PERF_ON_AC" = 100;
    "MAX_PERF_ON_BAT" = 60;
  };

  # Battery statistics
  services.upower.enable = true;

}
