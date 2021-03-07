args@{ nixosConfig, config, lib, pkgs, unstablePkgs, utilities, ... }:
let
  inherit (builtins) attrValues head;
  inherit (lib) hasSuffix fileContents mapAttrs' mkIf mkOption mkEnableOption
    nameValuePair removeSuffix types;
  inherit (config.lib.base16) base16template;
  inherit (utilities) flattenAttrs dirsToAttrs;

  cfg = config.modules.desktop-manager.awesome;

  # TODO explain this (broken hm module or something where the module and package didnt align)
  getLuaPath = lib: dir: "${lib}/${dir}/lua/${pkgs.lua53Packages.lua.luaversion}";
  makeSearchPath = lib.concatMapStrings (path:
    " --search ${getLuaPath path "share"}"
    + " --search ${getLuaPath path "lib"}");

  defaultProgramOptions = {
    class = mkOption {
      type = types.str;
      description = "The X11 window class name for this program.";
    };
    exec = mkOption {
      type = types.str;
      description = "The command to run this program.";
    };
    package = mkOption {
      type = types.package;
      description = "The package for this program";
    };
  };

in
{

  imports = [ ./.. ];

  ##### interface

  options = {

    modules.desktop-manager.awesome.enable = mkEnableOption "Enable AwesomeWM home-manager module.";

    modules.desktop-manager.awesome.defaultPrograms.terminal = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.browser  = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.research = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.editor   = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.social   = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.media    = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.games    = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.graphics = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.sandbox  = defaultProgramOptions;

    modules.desktop-manager.awesome.defaultPrograms.files    = defaultProgramOptions;

    # TODO modules.desktop-manager.awesome.components

    modules.desktop-manager.awesome.widgets = {
      email = {
        emailAddress = mkOption {
          type = types.str;
          description = "Email address to fetch mail for.";
        };
        emailAppPassword = mkOption {
          type = types.str;
          description = "Email app password, not to be confused with login password.";
        };
        imapServer = mkOption {
          default = "imap.google";
          type = types.str;
          description = "IMAP server for the specified account.";
        };
        port = mkOption {
          default = "993";
          type = types.str;
          description = "IMAP port for the specified server";
        };
      };
      weather = {
        apiToken = mkOption {
          type = types.str;
          description = "openweathermap.org api token.";
        };
        cityId = mkOption {
          type = types.str;
          description = "openweathermap.org city id.";
        };
        refreshInterval = mkOption {
          default = "1200";
          type = types.str;
          description = "The refresh interval in seconds as a string.";
        };
      };
    };
  };

  ##### implementation

  config = mkIf cfg.enable {

    xsession.windowManager.command =
      "${pkgs.awesome}/bin/awesome " + makeSearchPath (attrValues {
        inherit (pkgs.lua53Packages)
          luarocks       # is the package manager for Lua modules
          luadbi-mysql   # is a database abstraction layer
          luafilesystem; # is a library for fs interaction
      });

    # Packages required for this AwesomeWM configuration to work.
    home.packages = [
      pkgs.awesome          # window manager (overlaid)
      pkgs.picom            # compositor (overlaid)
      pkgs.rofi             # menu launcher
      pkgs.redshift         # night light
      pkgs.libcanberra-gtk3 # sound player
      pkgs.upower           # battery info
      cfg.defaultPrograms.terminal.package
      cfg.defaultPrograms.browser.package
      cfg.defaultPrograms.editor.package
      cfg.defaultPrograms.social.package
      cfg.defaultPrograms.media.package
      cfg.defaultPrograms.games.package
      cfg.defaultPrograms.graphics.package
      cfg.defaultPrograms.sandbox.package
      cfg.defaultPrograms.research.package
      cfg.defaultPrograms.files.package
    ];

    # Configuration files for AwesomeWM
    xdg.configFile = {

      # Source the local picom configuration which has
      # been tailored for this AwesomeWM configuration.
      "picom/picom.conf".source = toString ./picom.conf;

    # Build the AwesomeWM configuration and symlink to all the files
    # from XDG_CONFIG_DIR where awesome expects them to be.
    } // mapAttrs'
      (n: v:
        if hasSuffix ".nix" n
        then
          nameValuePair
            ("awesome/${removeSuffix ".nix" n}")
            ({ source = import v args;})
        else
          nameValuePair
            ("awesome/${n}")
            ({ source = v; })
      )
      (flattenAttrs (dirsToAttrs (toString ./config)));

  };
}
