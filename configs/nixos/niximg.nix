{ modulesPath, pkgs, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma5.nix" ];

  # generic user present in nixos iso image
  users.users.nixos = {
    uid = 1000;
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  #nixpkgs.config.allowBroken = true;

  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_11.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
            url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
            sha256 = "sha256-kEpbPLr1Jk742mx6VEX6fqGRaK13+4OnzBuLqV1S0KA=";
      };
      version = "5.11.2";
      modDirVersion = "5.11.2";
      };
  });

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  networking.networkmanager.enable = true;
}
