{ lib, ... }:
{
  deployment.targetEnv = "hetznercloud";
  deployment.hetznerCloud = {
    apiToken = lib.fileContents ../../../data/secret/hetznercloud-api-token;
    location = "nbg1";
    serverType = "cx31";
  };
}
