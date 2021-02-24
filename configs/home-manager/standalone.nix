# Home Manager configuration for work machines which I have a user account on.
{ ... }:
{
  imports = [
    ../../profiles/home-manager/developer
    ../../profiles/home-manager/email
    ../../profiles/home-manager/mac-sync-app-folder.nix
  ];
}
