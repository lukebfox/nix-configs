{ config, lib, pkgs, unstablePkgs, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.development;
in
{

  ##### interface

  options = {
    modules.development.enable = mkEnableOption "Enable system module for development.";
  };

  ##### implementation

  config = mkIf cfg.enable {

    # Install devman pages
    documentation.dev.enable = true;

    # Language API browser
    environment.systemPackages = attrValues {
      inherit (unstablePkgs)
        gh
        nix-index
        nix-prefetch-git;
    };
  };

}
