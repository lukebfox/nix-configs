{ config, lib, pkgs, unstablePkgs, shared, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mkDefault;
  inherit (shared.users.lukebfox) ssh-public-key;
in
{

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = unstablePkgs.nixUnstable;
    gc = {
      automatic = mkDefault true;
      dates = mkDefault "00:00";
      options = mkDefault "--delete-older-than 7d";
    };
    settings = {
      system-features = [ "nixos-test" "benchmark" ];
      auto-optimise-store = mkDefault true;
      extra-sandbox-paths = [ "/bin/sh=${pkgs.bash}/bin/sh" ]; # https://github.com/NixOS/nixpkgs/issues/124372
      trusted-substituters = [
      # "https://iohk.cachix.org"
      ];
      trusted-public-keys = [
        # "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      ];
      allowed-users = [ "@wheel" ];
      trusted-users = [ "root" "@wheel" ];
    };
    extraOptions = mkDefault ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  boot.cleanTmpDir = mkDefault true;

  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  time.timeZone = mkDefault "Europe/London";
  console.useXkbConfig = true;

  environment.systemPackages = attrValues {
    inherit (pkgs)
      coreutils     # These
      moreutils     # are
      binutils      # just
      iputils       # really
      dnsutils      # useful.
      vim           # Backup editor.
      git git-crypt # Version control.
      curl          # TCP/IP transfer tool.
      ranger        # File browser.
      neofetch      # System info.
      mkpasswd      # Word hasher.
      gptfdisk      # Filesystem
      dosfstools    # utilities.
      manpages      # Core manual.
      stdmanpages   # More manual.
      utillinux;    # I forgot why I had this but it was probably important.

    inherit (pkgs.gitAndTools) git-ignore;
  };

  # GPG agent (required for my ssh-only git account).
  programs.gnupg.agent.enable = mkDefault true;

  # Enable early out of memory killing.
  services.earlyoom.enable = mkDefault true;

  users.users.root.openssh.authorizedKeys.keys = [ ssh-public-key ];

  # TODO move these to the modules or profiles which require them.
  modules.user-manager = {
    userGroups = [
      "audio"
      "dialout"
      "disk"
      "fuse"
      "video"
    ];
  };

  hardware.enableRedistributableFirmware = mkDefault true;
  hardware.enableAllFirmware = mkDefault true;
}
