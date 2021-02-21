{ secrets, ... }:
{
  deployment.targetEnv = "hetznercloud";
  deployment.hetznerCloud = {
    apiToken = secrets.hetznercloud-api-token;
    location = "nbg1";
    serverType = "cx11";
  };
}
