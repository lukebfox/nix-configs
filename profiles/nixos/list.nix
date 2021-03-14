# Note: home-manager profiles aren't included in this list as they depend on
# non-standard arguments e.g. user, theme, variant, dotfiles ... Whereas all
# included profiles rely only on that which is explicitly imported in the flake.

[

  ## Building-block profiles ##
  ./hardened

  ./headless
  ./headless/qemu-guest.nix

  ./laptop

  ./misc/syncthing.nix
  ./misc/yubikey.nix

  ./virtualisation/docker.nix
  ./virtualisation/libvirtd.nix
  ./virtualisation/vbox-host.nix

  ## Composite profiles ##
  ./desktop
  ./workstation

]
