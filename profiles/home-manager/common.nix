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
      vim           # Backup editor.
      bat           # Better cat.
      curl          # TCP/IP transfer tool.
      git git-crypt # Version control.
      neofetch      # System info.
      htop          # Better top.
      ripgrep       # grep alternative.
      fd            # find alternative.
      bzip2
      gzip
      p7zip
      procs
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
    scheme  = mkDefault "unclaimed";
    variant = mkDefault "monokai";
    extraParams.tone = mkDefault "dark";
  };

  # Set once for backwards compatibility, don't change.
  home.stateVersion = "21.05";
}
