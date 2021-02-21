# Standard generic home-manager configuration. Currently only used by one user, me.
# See my user-manager module definition for further details.
{ ... }:
{
  imports = [
    ../../profiles/home-manager/desktop
    ../../profiles/home-manager/developer
  ];
}
