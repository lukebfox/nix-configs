{ lib, ... }:
let
  inherit (lib) fileContents;
in
{
  deployment.targetEnv = "hetznercloud";
  deployment.hetznerCloud = {
    apiToken = fileContents ../../../../data/secret/hetznercloud-api-token;
    location = "nbg1";
  };
}
