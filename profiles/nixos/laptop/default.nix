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

  # CUPS printing.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

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

  # Battery statistics
  services.upower.enable = true;

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

  # REVIEW does this interfere with window managers?
  sound.mediaKeys = {
    enable = true;
    volumeStep = "1dB";
  };

  # Better NTP timesync for unstable internet connections.
  services.chrony.enable = true;
  services.timesyncd.enable = false;

  # Weekly fstrim for SSD.
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  # REVIEW how this fits in with gdm and awesomeWM
  services.logind.lidSwitch = "suspend";

  # Power management features.
  services.tlp.enable = true;
  services.tlp.settings = {
    "CPU_SCALING_GOVERNOR_ON_AC" = "performance";
    "CPU_SCALING_GOVERNOR_ON_BAT" = "powersave";
    "CPU_HWP_ON_AC" = "performance";
    "MAX_PERF_ON_AC" = 100;
    "MAX_PERF_ON_BAT" = 60;
  };

}
