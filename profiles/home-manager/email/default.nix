{ config, lib, pkgs, utilities, ... }:
let
  inherit (config.home) username;

  userSecrets = utilities.importSecrets
    (../../../data/secret/user + "/${username}");
in
{
  accounts.email.accounts.${username} = {
    primary = true;
    address = userSecrets.email-address;
    aliases = [];
  };
}
