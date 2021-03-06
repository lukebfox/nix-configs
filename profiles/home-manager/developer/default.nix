{ config, lib, pkgs, shared, ... }:
let
  inherit (lib) mkDefault fileContents;
  inherit (config.home) username;

  address = fileContents
    (../../../data/secret/user + "/${username}/email-address");
in
{
  modules = {
    editor = {
      enable = true;
      emacs.enable = true;
    };
    shell = {
      enable = true;
      zsh.enable = true;
    };
    terminal = {
      kitty.enable = true;
    };
    tools = {
      git = {
        enable = true;
        userName = username;
        userEmail = address;
        signingKey = address;
      };
      colorls.enable = true;
    };
  };
}
