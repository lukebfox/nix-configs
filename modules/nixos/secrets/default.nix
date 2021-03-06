{ config, lib, pkgs, unstablePkgs, shared, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mapAttrs' mkIf mkMerge mkOption mkEnableOption optional types readFile;

  # To encrypt secrets we must use the ssh host public key of the target machine.
  # This module supports two methods of deployment, nixops and nixos-rebuild.
  # `nixops deploy` will include the public keys of all machines in knownHosts
  # after generating the keypairs. `nixos-rebuild` does not generate a keypair
  # and the public host key is not available within nix, until we read it in.
  inherit (config.networking) hostName;
  inherit (config.services.openssh) knownHosts;
  publicKey = if knownHosts?hostName
              then knownHosts.${hostName}.publicKey
              else shared.hosts.${hostName}.ssh-public-key;

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

  mkSecretOnDisk = name:
    { source, ... }:
    pkgs.stdenv.mkDerivation {
      name = "${name}-secret";
      phases = "installPhase";
      buildInputs = [ pkgs.age ];
      installPhase = ''
        age -a -r "${publicKey}" -o $out ${source}
      '';
    };

  mkService = name:
    { source, dest, owner, group, permissions, ... }: {
      description = "decrypt secret for ${name}";
      wantedBy = [ "multi-user.target" ];

      serviceConfig.Type = "oneshot";

      script = ''
        rm -rf ${dest}
        ${pkgs.age}/bin/age -d -i /etc/ssh/ssh_host_ed25519_key -o ${dest} ${
          mkSecretOnDisk name { inherit source; }
        }
        chown ${owner}:${group} ${dest}
        chmod ${permissions} ${dest}
      '';
    };

in
{

  options.modules.secrets = mkOption {
    type = types.attrsOf secret;
    description = "secret configuration";
    default = {};
  };

  config.systemd.services = let
    units = mapAttrs' (name: info: {
      name = "${name}-key";
      value = (mkService name info);
    }) cfg;
  in units;

}
