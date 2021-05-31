{ config, lib, pkgs, ... }:
let
  initExtra = ''
    export PATH="$HOME/Projects/code/ops/bin/:$PATH";
    alias j="ssh jump -t luminance-jumpcli ssh";
    releaseoff () {
        git log $1 --decorate=full | grep 'tag:' | sed -E "s/^.*tag: refs\/tags\/([^ ,\)]+).*$/\1/g" | grep '^v' | head -n 1
    }
    releasedin () {
        git tag --contains $1 --sort=committerdate | grep '^v' | head -n 1
    }
  '';
in
{
  programs.bash = { inherit initExtra; };
  programs.zsh  = { inherit initExtra; };

  modules.terminal.iterm2.enable = true;
}
