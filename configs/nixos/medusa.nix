# A top-level nixos configuration for my Razer Blade 14 (2021)
{ pkgs, ... }:
let
  inherit (pkgs.linuxKernel.packages) linux_5_15;
  #  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  #    export __NV_PRIME_RENDER_OFFLOAD=1
  #    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #    export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #    export __VK_LAYER_NV_optimus=NVIDIA_only
  #    exec -a "$0" "$@"
  #  '';
in
{
  imports = [
    ../../profiles/nixos/laptop
    ../../profiles/nixos/razer
    ../../profiles/nixos/desktop
    ../../profiles/nixos/workstation
    ../../profiles/nixos/users/lukebfox
  ];

  ## Logical

  nix.systemFeatures = [ "big-parallel" ];

  # NVIDIA RTX3070
  #environment.systemPackages = [nvidia-offload]; # dont add me...
  services.xserver.videoDrivers = [ "modesetting" "nvidia" "amdgpu" ];
  hardware.nvidia = {
    package = linux_5_15.nvidia_x11_beta;
    powerManagement.enable = true;
    modesetting.enable = true;
    prime = {
      #sync.enable = true;
      offload.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };
  };

  # AMD RYZEN 9 5900HX
  hardware.cpu.amd.updateMicrocode = true;
  nix.maxJobs = 8; # Limit nix jobs to match number of cpu cores.

  # DUAL BOOT WINDOWS
  # Use system EFI boot loader.
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      gfxmodeEfi = "2560x1440";
      splashMode = "normal";
      theme = pkgs.nixos-grub2-theme;
      #font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
    };
  };
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "amdgpu" ];
    kernelModules = [ "dm-snapshot" ];
    # Declare luks partition.
    luks.devices.root = {
      # Use drive UUID not NAME.
      # The upgrade from Windows 10 to 11 added a partition in the middle of my
      # drive which offset the names of later partitions (i.e '/dev/nvme0n1p6'
      # became '/dev/nvme0n1p7') and screwed up stage 1 boot.
      device = "/dev/disk/by-uuid/6561d02e-f56a-4b91-8061-b30e72e8e3da";
      preLVM = true;
    };
  };
  boot.kernelPackages = linux_5_15;
  # Second stage kernel module loading
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [
    "acpi_osi=Linux"
    "acpi_backlight=vendor"
    "nouveau.modeset=0"
  ];
  boot.extraModulePackages = [ ];

  ## Physical

  # Declare partitions
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/eabf3cd6-1007-4983-be03-4b89afc946be";
      fsType = "xfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/E840-77FB";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/acf11f41-b903-4726-b279-0bd57f035348"; }];

  #DONTCHANGE
  system.stateVersion = "21.11";
}
