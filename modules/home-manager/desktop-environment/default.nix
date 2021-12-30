{ nixosConfig, config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.desktop-environment;
in
{

  ##### bundled modules

  imports = [
    ./gnome
  ];

  ##### interface
  
  options = {
    modules.desktop-environment.enable =
      mkEnableOption "Enable home-manager desktop module.";

    modules.desktop-environment.multimedia.enable =
      mkEnableOption "Enable home-manager desktop multimedia module.";
  };

  ##### implementation

  config = mkIf cfg.enable {

    home.packages = lib.optionals cfg.multimedia.enable (attrValues {
      inherit (pkgs)
        citrix_workspace
        vscode
        transmission  # torrent client
        nicotine-plus # soulseek
        gimp          # image editor
        inkscape      # svg editor
        vlc           # video player
        firefox;      # browser
    });
  };
}
