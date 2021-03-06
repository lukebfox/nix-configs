# Integrated home-manager configuration for use on machines managed by nix in their entirety.
# See my user-manager module definition for further details.
{ ... }:
{
  imports = [
    ../../profiles/home-manager/desktop
    ../../profiles/home-manager/developer
  ];
}
