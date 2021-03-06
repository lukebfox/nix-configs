# Home Manager module to iron out issues when deploying standalone configurations i.e
# configurations destined for systems unmanaged by nix e.g darwin, or fedora.
# Issues:
# - https://github.com/nix-community/home-manager/issues/1341
#
# This module shouldn't really exist and hopefully will be made redundant by improvements in HM
{ system, config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;

  cfg = config.modules.standalone;

  initExtra = ''
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
  '';

in
{
  options.modules.standalone.enable = mkEnableOption "Enable home-manager module for non-nixos systems.";

  config = mkIf cfg.enable (mkMerge [

    {
      programs.bash = { inherit initExtra; };
      programs.zsh  = { inherit initExtra; };
    }

    (mkIf (system == "x86_64-linux") {})

    (mkIf (system == "x86_64-darwin") {
      # Create launchpad entries
      # https://github.com/nix-community/home-manager/issues/1341#issuecomment-778820334
      home.activation = {
        copyApplications =
          let
            apps = pkgs.buildEnv {
              name = "home-manager-applications";
              paths = config.home.packages;
              pathsToLink = "/Applications";
            };
          in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            baseDir="$HOME/Applications/Home Manager Apps"
            if [ -d "$baseDir" ]; then
              rm -rf "$baseDir"
            fi
            mkdir -p "$baseDir"
            for appFile in ${apps}/Applications/*; do
              target="$baseDir/$(basename "$appFile")"
              $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
              $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
            done
          '';
      };
    })

  ]);
}
