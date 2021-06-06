{ config, shared, ... }:
let
  inherit (builtins) removeAttrs;
  inherit (shared.network) domain;
  inherit (config.networking) hostName;
in
{
  networking.firewall.allowedTCPPorts = [ 3000 ];

  # Hydra build farm
  services.hydra = {
    enable = true;
    useSubstitutes = true;
    hydraURL = "https://hydra.${domain}";
    notificationSender = "hydra@${domain}";
    smtpHost = "localhost";
    buildMachinesFiles = [];
    extraConfig = ''
      store_uri = file:///var/lib/hydra/cache?secret-key=/etc/nix/${hostName}/secret
      binary_cache_secret_key_file = /etc/nix/${hostName}/secret
      binary_cache_dir = /var/lib/hydra/cache
    '';
  };

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

  # Miscellaneous helper services.
  services.ntp.enable = true;
  services.openssh.allowSFTP = false;
  services.openssh.passwordAuthentication = false;
  services.postfix.enable = true;
  services.postfix.setSendmail = true;
  services.postfix.domain = domain;

  # One-time setup for the local binary cache we specified in `extraConfig`.
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
        /run/current-system/sw/bin/install -d -m 551 /etc/nix/${hostName} ;
        /run/current-system/sw/bin/nix-store --generate-binary-cache-key ${hostName} /etc/nix/${hostName}/secret /etc/nix/${hostName}/public
        /run/current-system/sw/bin/chown -R hydra:hydra /etc/nix/${hostName}
        /run/current-system/sw/bin/chmod 440 /etc/nix/${hostName}/secret
        /run/current-system/sw/bin/chmod 444 /etc/nix/${hostName}/public
        # create cache
        /run/current-system/sw/bin/install -d -m 755 /var/lib/hydra/cache
        /run/current-system/sw/bin/chown -R hydra-queue-runner:hydra /var/lib/hydra/cache
        # done
        touch ~hydra/.setup-is-complete
      fi
    '';
  };

  nix = {
    autoOptimiseStore = true;
    trustedUsers = ["hydra" "hydra-evaluator" "hydra-queue-runner"];
    buildMachines = [
      {  hostName = "localhost";
         systems = [ "x86_64-linux" ];
         maxJobs = 1;
         # for building VirtualBox VMs as build artifacts, you might need other
         # features depending on what you are doing
         supportedFeatures = [];
      }
    ];
    gc.automatic = true;
    gc.dates = "15 3 * * *";
  };
}
