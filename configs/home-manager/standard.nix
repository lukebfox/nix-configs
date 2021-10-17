# Integrated home-manager configuration for use on machines managed by nix in their entirety.
# See user-manager nixos module definition for further details.
{ ... }:
{
  imports = [
    ../../profiles/home-manager/developer
    ../../profiles/home-manager/desktop
    ../../profiles/home-manager/themes/monokai.nix
  ];
}
