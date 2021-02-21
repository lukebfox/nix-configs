{ config
, lib
, pkgs
, unstablePkgs
, base16
, shared
, secrets
, utilities
, ... } @ args:

let
  inherit (lib) mkOption types;
  inherit (utilities) recImport importSecrets;

in
{

  # Submodules have merge semantics, making it possible to amend
  # the `home-manager.users` submodule for additional functionality.
  options.home-manager.users = mkOption {
    type = types.attrsOf (types.submoduleWith {

      # Make custom home-manager modules available.
      modules = let
        common = ../../../profiles/home-manager/common.nix;
        flakeModules = import ../../../modules/home-manager/list.nix;
      in flakeModules ++ [ common base16.hmModules.base16 ];

      # Make various NixOS specialArgs available to Home Manager
      # modules as well. Would like to keep this list small!
      specialArgs = { inherit (args)
        unstablePkgs utilities shared secrets;
      };

    });
  };

  config = {
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
  };

}
