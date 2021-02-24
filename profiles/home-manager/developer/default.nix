{ config, lib, pkgs, shared, ... }:
let
  inherit (lib) mkDefault;
  inherit (shared.network) domain;
  inherit (config.home) username;
  inherit (config.accounts.email.accounts.${username}) address;

in
{
  modules.programs.kitty.enable = true;
  modules.programs.emacs.enable = true;
  modules.programs.zsh.enable = true;
  modules.programs.git = {
    enable = true;
    userName = username;
    userEmail = address;
    signingKey = address;
  };
}
