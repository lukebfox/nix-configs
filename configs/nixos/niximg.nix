{ modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/iso-image.nix" ];

  # generic user present in nixos iso image
  users.users.nixos = {
    uid = 1000;
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;
  networking.networkmanager.enable = true;
}
