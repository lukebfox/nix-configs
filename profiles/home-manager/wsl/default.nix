{ lib, ... }:
{
  home.file.".vscode-server/server-env-setup".text = lib.fileContents ./server-env-setup;
}
