# A top-level nixos configuration for my old HP laptop
{ pkgs, ... }:
{
  imports = [
    ../../profiles/nixos/laptop
    ../../profiles/nixos/desktop
    ../../profiles/nixos/workstation
    ../../profiles/nixos/users/lukebfox
  ];

  ## Logical

  services.printing.drivers = [ pkgs.hplip ];
  services.xserver.libinput.touchpad.clickMethod = "buttonareas";

  # Intel CPU
  hardware.cpu.intel.updateMicrocode = true;
  nix.maxJobs = 4; # Limit nix jobs to match number of cpu cores.

  # Use system EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };
  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "dm-snapshot" ];
    # Declare luks partition.
    luks.devices.root = {
      device = "/dev/sda2";
      preLVM = true;
    };
  };
  # Second stage kernel module loading.
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  ## Physical

  # Declare partitions
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f90957d0-89c7-4ab0-b272-6e964e83ac15";
      fsType = "ext4";
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AAE2-F830";
      fsType = "vfat";
    };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/25b75806-ee80-4e98-b867-eaabcd438e39"; }
    ];

  #DONTCHANGE
  system.stateVersion = "21.05";
}
