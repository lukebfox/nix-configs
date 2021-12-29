{ config, lib, pkgs, unstablePkgs, shared, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) fileContents mkDefault;
  inherit (shared.users.lukebfox) ssh-public-key;
in
{

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = unstablePkgs.nixUnstable;
    systemFeatures = [ "nixos-test" "benchmark" ];
    autoOptimiseStore = mkDefault true;
    gc.automatic = mkDefault true;
    gc.dates = mkDefault "00:00";
    gc.options = mkDefault "--delete-older-than 7d";
    sandboxPaths = [ "/bin/sh=${pkgs.bash}/bin/sh" ]; # https://github.com/NixOS/nixpkgs/issues/124372
    trustedBinaryCaches = [
      # "https://iohk.cachix.org"
    ];
    binaryCachePublicKeys = [
      # "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = mkDefault ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes ca-references
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

  users.users.root = {
    initialHashedPassword = mkDefault "$6$Br94NDGbCd44UN1f$cDJaZ8YWYKp9fzVyIrkdQaG8ZMca4IXqcqX2v2So80taR/YqnLhYACaiZ/EDo/UkjDiOUUOi3f8/ovzCg7Ewg1";
    openssh.authorizedKeys.keys = [ ssh-public-key ];
  };

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
