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
      # Make various NixOS specialArgs available to Home Manager
      # modules as well. Would like to keep this list small!
      specialArgs = { inherit (args)
        unstablePkgs utilities shared secrets;
      };
      # Make custom home-manager modules available.
      modules = (import ../../../modules/home-manager/list.nix) ++ [
        (base16.homeManagerModules.base16)
        ../../../profiles/home-manager/common.nix
      ];
    });
  };

  config = {
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
  };

}
