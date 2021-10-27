{ pkgs, modulesPath, ... }:

{
  imports = [
    ../../profiles/nixos/headless
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  environment.systemPackages = [ pkgs.hello pkgs.firacode-nerdfont ];

  boot.loader.grub.device = "nodev";
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
}
