{ config, lib, pkgs, ... }:
let
  initExtra = ''
    export PATH="$HOME/Projects/ops/bin/:$PATH";
  '';
in
{
  home.packages = [ pkgs.jitsi-meet ];

  programs.bash = { inherit initExtra; };
  programs.zsh  = { inherit initExtra; };

  modules.terminal.iterm2.enable = true;
}
