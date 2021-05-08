# A top level Home Manager configuration for work machines
# which I have a user account on.
{ ... }:
{
  imports = [
    ../../profiles/home-manager/work
    ../../profiles/home-manager/developer
  ];
}
