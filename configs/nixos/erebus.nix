{ shared, ... }:
{
  imports = [
    ../../profiles/nixos/laptop
    ../../profiles/nixos/desktop
    ../../profiles/nixos/workstation
  ];

  modules.user-manager.users = {
    lukebfox = {
      homeDirectory = "/home/lukebfox";
      home = ../home-manager/standard.nix;
      isAdmin = true;
      uid = 1000;
    };
  };

  # FIXME https://github.com/NixOS/nixpkgs/issues/103746
  #services.xserver.displayManager.autoLogin = {
  #  enable = true;
  #  user = "lukebfox";
  #};

  # TODO place below into profiles where possible.

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

  # Limit nix jobs to match number of cpu cores.
  nix.maxJobs = 4;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

}
