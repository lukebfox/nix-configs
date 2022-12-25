{ ... }:
{
  modules.user-manager.users = {
    lukebfox = {
      homeDirectory = "/home/lukebfox";
      home = ../../../../configs/home-manager/wsl.nix;
      isAdmin = true;
      uid = 1000;
    };
  };
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "lukebfox";
  };
}
