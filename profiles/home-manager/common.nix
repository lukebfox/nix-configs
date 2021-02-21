{ nixosConfig, config, lib, pkgs, ... }:

let
  inherit (nixosConfig.modules.user-manager) users;
  inherit (config.home) username;
  inherit (lib) mkDefault;

in
{

  # Set the base16 theme for the user (the default definition for userTheme is {}).
  themes.base16 = users.${username}.userTheme;

  # But of course :)
  # No US keyboard domination in my backyard! (salty)
  home.keyboard.layout = lib.mkDefault "gb";

  # Discover fonts installed through `home.packages`.
  fonts.fontconfig.enable = lib.mkDefault true;

  # Colorls configuration. I don't use base16 here because my terminal
  # emulator uses base16 and so the colors are mapped appropriately.
  modules.programs.colorls = {
    enable = true;
    colors = {
      # Main Colors
      unrecognized_file = "blue";
      recognized_file =   "white";
      dir =               "blue";
      # Link
      dead_link = "red";
      link =      "cyan";
      # special files
      socket =    "yellow";
      blockdev =  "yellow";
      chardev =   "yellow";
      # Access Modes
      read =      "green";
      write =     "yellow";
      exec =      "red";
      no_access = "black";
      # Age
      day_old =     "lightgray";
      hour_old =    "white";
      no_modifier = "gray";
      # File Size
      file_large =  "red";
      file_medium = "yellow";
      file_small =  "white";
      # Random
      report = "white";
      user =   "cyan";
      normal = "darkkhaki";
      tree =   "blue";
      empty =  "blue";
      error =  "red";
      # Git
      addition =     "green";
      modification = "yellow";
      deletion =     "red";
      untracked =    "magenta";
      unchanged =    "white";
    };
  };

  # Direnv configuration
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    config.global.warn_timeout = "1m";
  };

}
