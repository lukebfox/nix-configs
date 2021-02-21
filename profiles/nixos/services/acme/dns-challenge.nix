{ shared, ... }:
let
  inherit (shared.network) domain;

  credentialsDestination = "/run/keys/acme-dns-creds";
in
{
  # Wildcard certificate issued via DNS-01 challenge.
  security.acme = {
    acceptTerms = true;
    email = "admin+acme@${domain}";
    certs."${domain}" = {
      domain = "*.${domain}";
      extraDomainNames = [domain];
      dnsProvider = "cloudflare";
      credentialsFile = credentialsDestination;
      dnsPropagationCheck = true;
    };
  };

  # Distribute secret via nixos module instead of `deployment.keys`.
  # Encrypted in nix-store, and persists between reboots.
  modules.secrets.acme-dns-creds = {
    source = ../../../../data/secret/acme-cloudflare-creds-file;
    dest = credentialsDestination;
    owner = "acme";
    group = "acme";
    permissions = "0640";
  };

}
