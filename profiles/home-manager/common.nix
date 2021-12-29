# Default configuration for all home-manager configs
{ config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mkDefault;
in
{

  # No US keyboard domination in my backyard! (salty)
  home.keyboard.layout = mkDefault "gb";

  # Basic packages for all my users.
  home.packages = attrValues {
    inherit (pkgs)
      coreutils     # These
      moreutils     # are
      binutils      # just
      dnsutils      # useful.
      # GNU replacements
      htop          # top
      exa           # ls (rust)
      ripgrep       # grep (rust)
      bat           # cat (rust)
      fd            # find (rust)
      procs         # ps (rust)
      # Common utils
      curl          # TCP/IP transfer tool.
      jq            # JSON manipulator
      rustscan      # Better nmap (rust).
      socat # Netcat, curl and socat for WebSockets (rust).
      tealdeer      # Better tldr (rust).
      neofetch      # System info.
      # Archive utils
      bzip2
      gzip
      p7zip
      unrar
      unzip;
    };

  # XDG desktop specification
  xdg = {
    enable = mkDefault true;
    userDirs.enable = mkDefault true;
    userDirs.extraConfig.XDG_PROJECTS_DIR = "$HOME/Projects";
  };

  # Default theme
  themes.base16 = {
    scheme  = mkDefault "gruvbox";
    variant = mkDefault "gruvbox-dark-hard";
    extraParams.tone = mkDefault "dark";
  };

  # Set once for backwards compatibility, don't change.
  home.stateVersion = "21.05";
}
