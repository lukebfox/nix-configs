# Home-manager module to iron out any issues when deploying standalone configurations.
# This means any configurations destined for systems unmanaged by nix (via nixos/nix-darwin)
# e.g darwin, or fedora.
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
