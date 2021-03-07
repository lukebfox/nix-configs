{ config, lib, pkgs, ... }:
{
  modules.standalone.enable = true;

  # Enable installation of proprietary software.
  nixpkgs.config.allowUnfree = true;
}
