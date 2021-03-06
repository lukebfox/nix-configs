{ config, lib, pkgs, ... }:
{
  # Enable installation of proprietary software.
  nixpkgs.config.allowUnfree = true;

  modules.targets.standalone = true;
  modules.targets.isDarwin = true;
  modules.terminal.iterm2.enable = true;

}
