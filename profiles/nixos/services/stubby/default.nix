# Use DNS-over-TLS to increase privacy, with a local DNS cache for efficiency.
{...}:
{
  # Enable Stubby, a local DNS Privacy stub resolver.
  services.stubby = {
    enable = true;
    upstreamServers = ''
      - address_data: 1.1.1.1
        tls_port: 853
        tls_auth_name: "cloudflare-dns.com"
      - address_data: 1.0.0.1
        tls_port: 853
        tls_auth_name: "cloudflare-dns.com"
    '';
    # In order to forward to a local DNS cache, Stubby should listen on a port
    # different from the default 53, since the DNS cache itself needs to listen
    # on 53 and query Stubby on a different port.
    listenAddresses = [
      "::1@53000"
      "127.0.0.1@53000"
    ];
  };

  # Replace DNS resolver.
  environment.etc."resolv.conf" = {
    text = ''
      options edns0
      nameserver ::1
      nameserver 127.0.0.1
    '';
    mode = "444";
  };


  # Configure local DNS cache server.
  services.dnsmasq.enable = true;
  environment.etc."dnsmasq.conf" = {
    text = ''
      no-resolv
      proxy-dnssec
      server=::1#53000
      server=127.0.0.1#53000
      listen-address=::1,127.0.0.1
    '';
  };

  # Disable NetworkManager default DNS.
  networking = {
    networkmanager.dns = "none";
    resolvconf.dnsExtensionMechanism = false;
  };
}
