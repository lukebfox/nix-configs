#FIXME
{ config, shared, ... }:
let
  inherit (builtins) removeAttrs;
  inherit (shared) domain;
in
{
  imports = [../nginx/reverse-proxy.nix];

  # Prepare the beast
  services.hydra = {
    enable = true;
    useSubstitutes = true;
    hydraURL = "https://hydra.${domain}";
    notificationSender = "hydra@${domain}";
    buildMachinesFiles = [];
    extraConfig = ''
      store_uri = file:///var/lib/hydra/cache?secret-key=/etc/nix/<HOSTNAME>/secret
      binary_cache_secret_key_file = /etc/nix/<HOSTNAME>/secret
      binary_cache_dir = /var/lib/hydra/cache
    '';
  };

  # Miscellaneous helper services.
  services.ntp.enable          = true;
  services.openssh.allowSFTP   = false;
  services.postfix.enable      = true;
  services.postfix.setSendmail = true;

  # Configure postgreSQL database.
  services.postgresql = {
    enable = true;
    identMap = ''
      hydra-users hydra hydra
      hydra-users hydra-queue-runner hydra
      hydra-users hydra-www hydra
      hydra-users root postgres
      hydra-users postgres postgres
    '';
  };

  # Nginx reverse proxy entry.
  services.nginx.virtualHosts."hydra.${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:3000";
      proxyWebsockets = true;
    };
  };

  # TODO what is this important thing?
  systemd.services.hydra-manual-setup = {
    description = "Create Admin User for Hydra";
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
    wantedBy = [ "multi-user.target" ];
    requires = [ "hydra-init.service" ];
    after = [ "hydra-init.service" ];
    environment = removeAttrs (config.systemd.services.hydra-init.environment) ["PATH"];
    script = ''
      if [ ! -e ~hydra/.setup-is-complete ]; then
        # create signing keys
        /run/current-system/sw/bin/install -d -m 551 /etc/nix/<HOSTNAME>
        /run/current-system/sw/bin/nix-store --generate-binary-cache-key <HOSTNAME> /etc/nix/<HOSTNAME>/secret /etc/nix/<HOSTNAME>/public
        /run/current-system/sw/bin/chown -R hydra:hydra /etc/nix/<HOSTNAME>
        /run/current-system/sw/bin/chmod 440 /etc/nix/<HOSTNAME>/secret
        /run/current-system/sw/bin/chmod 444 /etc/nix/<HOSTNAME>/public
        # create cache
        /run/current-system/sw/bin/install -d -m 755 /var/lib/hydra/cache
        /run/current-system/sw/bin/chown -R hydra-queue-runner:hydra /var/lib/hydra/cache
        # done
        touch ~hydra/.setup-is-complete
      fi
    '';
  };

  # Just nix things.
  nix = {
    autoOptimiseStore = true;
    trustedUsers = ["hydra" "hydra-evaluator" "hydra-queue-runner"];
    buildMachines = [
      {  hostName = "localhost";
         systems = [ "x86_64-linux" "i686-linux" ];
         maxJobs = 2;
         # for building VirtualBox VMs as build artifacts, you might need other
         # features depending on what you are doing
         supportedFeatures = [ ];
      }
    ];
    gc.automatic = true;
    gc.dates = "15 3 * * *";
  };
}
