{ nixosConfig, config, lib, pkgs, utilities, shared, ... }:
let
  inherit (lib) fileContents;
  inherit (shared.network) domain;
  inherit (config.home) username;

  # FIXME
  mkUnsafeUserSecret = path:
    fileContents
      (../../../data/secret/user + "/${username}/${path}");
in
{
  modules = {

    gaming = {
      enable = true;
      games = [ pkgs.minecraft ];
    };

    music.enable = true;

    social.enable = true;

    desktop-manager = {
      enable = true;
      awesome = {
        enable = true;
        defaultPrograms = {
          terminal = {
            package = pkgs.kitty;
            class = "kitty";
            exec = "kitty";
          };
          browser = {
            package = pkgs.firefox;
            class = "Firefox";
            exec = "firefox";
          };
          research = {
            package = pkgs.mendeley;
            class = "Mendeley";
            exec = "mendeleydesktop";
          };
          editor = {
            package = config.programs.emacs.finalPackage;
            class = "Emacs";
            exec = "emacs";
          };
          social = {
            package = pkgs.zoom-us;
            class = "zoom";
            exec = "zoom-us";
          };
          media = {
            package = pkgs.spotify;
            class = "Spotify";
            exec = "spotify";
          };
          games = {
            package = pkgs.steam;
            class = "Steam";
            exec = "steam";
          };
          graphics = {
            package = pkgs.inkscape;
            class = "Inkscape";
            exec = "inkscape";
          };
          sandbox = {
            package = pkgs.virtualbox;
            class = "VirtualBox\ Manage";
            exec = "VirtualBox";
          };
          files = {
            package = pkgs.gnome3.nautilus;
            class = "org.gnome.Nautilus";
            exec = "nautilus";
          };
        };
        widgets = {
          email = {
            emailAddress = mkUnsafeUserSecret "email-address";
            emailAppPassword = mkUnsafeUserSecret "email-app-password";
          };
          weather = {
            apiToken = "4cad27b26a2f1334cadde0e6cf1c7023";
            cityId = "2649911";
            refreshInterval = "1200";
          };
        };
      };
    };
  };
}
