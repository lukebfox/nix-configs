  # Manage secrets with home-manager. Keep encrypted secrets in the nix store,
  # and install decrypted copies upon activation. This module is intended to be
  # used in standalone home-manager installations.
{ config, lib, pkgs, unstablePkgs, shared, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mapAttrs mkIf mkMerge mkOption mkEnableOption optional types readFile;

  cfg = config.modules.secrets;

  secret = types.submodule {
    options = {
      source = mkOption {
        type = types.path;
        description = "Local secret path.";
      };
      dest = mkOption {
        type = types.str;
        description = "Where to write the decrypted secret to.";
      };
      owner = mkOption {
        default = "root";
        type = types.str;
        description = "Who should own the secret.";
      };
      group = mkOption {
        default = "root";
        type = types.str;
        description = "What group should own the secret.";
      };
      permissions = mkOption {
        default = "0400";
        type = types.str;
        description = "Permissions expressed as octal.";
      };
    };
  };

  # To encrypt secrets we must use the ssh public key of the target user.
  publicKey = shared.users.${config.home.username}.ssh-public-key;

  # Function which returns a nix store path for an encrypted secret.
  mkSecretOnDisk = name:
    { source, ... }:
    pkgs.stdenv.mkDerivation {
      name = "${name}-secret";
      phases = "installPhase";
      buildInputs = [ pkgs.age ];
      installPhase = ''
        ${pkgs.age}/bin/age -a -r "${publicKey}" -o $out ${source}
      '';
    };

  # Function which returns an activation script for a secret.
  mkSecretActivationScript = name:
    { source, dest, owner, group, permissions, ... }:
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      rm -rf ${dest}
      ${pkgs.age}/bin/age -d -i ${config.home.homeDirectory}/.ssh/id_rsa -o ${dest} ${
        mkSecretOnDisk name { inherit source; }
      }
      chown ${owner}:${group} ${dest}
      chmod ${permissions} ${dest}
    '';

in
{

  options.modules.secrets = mkOption {
    type = types.attrsOf secret;
    description = "Secrets configuration";
    default = {};
  };

  config.home.activation = mapAttrs mkSecretActivationScript cfg;

}
