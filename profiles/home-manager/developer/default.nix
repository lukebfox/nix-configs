{ config, nixosConfig, lib, pkgs, shared, ... }:
let
  inherit (lib) fileContents;
  inherit (config.home) username;

  address = fileContents
    (../../../data/secret/user + "/${username}/email-address");
in
{
  modules = {
    editor = {
      enable = true;
      emacs.enable = true;
      vscode.enable = !nixosConfig.wsl.enable;
    };
    cli = {
      enable = true;
      zsh.enable = true;
      kitty.enable = true;
      colorls.enable = true;
      git = {
        enable = true;
        userName = username;
        userEmail = address;
        signingKey = address;
      };
    };
  };
}
