{ nixosConfig, config, lib, pkgs, utilities, shared, secrets, ... }:
let
  inherit (shared.network) domain;

  userSecrets = utilities.importSecrets
    (../../../data/secret/user + "/${config.home.username}");

  inherit (userSecrets) gmail-address gmail-app-password;
in
{

  #home.file."Templates".source = pkgs.templates;

  modules.desktop = {
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
      #components = {};
      widgets = {
        email = {
          emailAddress = gmail-address;
          emailAppPassword = gmail-app-password;
        };
        weather = {
          apiToken = "4cad27b26a2f1334cadde0e6cf1c7023";
          cityId = "2649911";
          refreshInterval = "1200";
        };
      };
    };
  };

  modules.programs.kitty.enable = true;

  modules.programs.emacs.enable = true;

  modules.programs.zsh.enable = true;

  modules.programs.git = {
    enable = true;
    userName = config.home.username;
    userEmail = "mail@${domain}";
    signingKey = "mail@${domain}";
  };

}
