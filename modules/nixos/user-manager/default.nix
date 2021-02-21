/* This module is an abstraction of the standard NixOS user model. Sitting
   above both 'users.users', and 'home-manager.users', users defined with this
   module have their definitions for both the aforementioned options
   automatically created. Some programs require users be added to some system
   group, which this module handles.
*/
{ config, lib, pkgs, shared, utilities, ... }:

with lib;

let
  inherit (utilities) mapFilterAttrs recImport;
  inherit (shared.users.lukebfox) ssh-public-key;


  cfg = config.modules.user-manager;

  userOpts = { name, ... }: {
    options = {
      hmConfig = mkOption {
        default = null;
        type = types.nullOr types.path;
        description = ''
          The path to the home-manager configuration to build for this user.
        '';
      };
      isAdmin = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Whether the user has admin priviledges i.e. added to wheel.
        '';
      };
      # TODO get rid of this horrible mirroring.
      # mirrors 'home-manager.users.<name?>.themes.base16
      userTheme = mkOption {
        default = null;
        type = types.nullOr types.attrs;
      };
      # mirrors 'users.users' options
      home = mkOption {
        default = "/home/${name}";
        type = types.str;
      };
      uid = mkOption {
        type = types.int;
      };
    };
  };

in
{

  ##### interface

  options = {
    modules.user-manager.users = mkOption {
      default = {};
      type = types.attrsOf (types.submodule userOpts);
      description = ''
        Users to be managed by this module. Intuitively this option enables
        extra user-specific options compared to 'users.users'. For users
        managed by user-manager, their definitions for 'users.users' and
        'home-manager.users' are not intended to be written manually but derived
        from this definition. As a result, some of those modules' options must
        be mirrored here, however the benefits outweight the detriments.
      '';
    };
    modules.user-manager.userGroups = mkOption {
      default = [];
      type = types.listOf types.str;
      description = "The list of groups which all managed users are added to.";
    };
  };

  ##### implementation

  config = {

    # Sane defaults.
    users.mutableUsers = false;
    users.groups.builders = { gid = 1999; };

    # Define a nixos user for every user-manager user definition.
    users.users =
      mapAttrs
        (_: { uid, home, isAdmin, ... }: {
          inherit uid home;
          extraGroups =
            [ "builders" ]
            ++ cfg.userGroups
            ++ (optional isAdmin "wheel")
            ++ (optional config.modules.network.enable "networkmanager")
            ++ (optional config.hardware.pulseaudio.enable "audio");
          shell = pkgs.zsh;
          isNormalUser = true;
          hashedPassword = mkDefault "$6$Br94NDGbCd44UN1f$cDJaZ8YWYKp9fzVyIrkdQaG8ZMca4IXqcqX2v2So80taR/YqnLhYACaiZ/EDo/UkjDiOUUOi3f8/ovzCg7Ewg1";
          # SSH access to all my users via my yubikey, don't try this at home kids.
          openssh.authorizedKeys.keys = [ ssh-public-key ];
        })
        cfg.users;

    # Build the home-manager configuration for all users who specified
    # one with `modules.user-manager.users.<name?>.hmConfig`.
    home-manager.users =
      mapFilterAttrs
        (username: { hmConfig, ... }: nameValuePair username (import hmConfig))
        (_: { hmConfig, ... }: hmConfig != null)
        cfg.users;

  };

}
