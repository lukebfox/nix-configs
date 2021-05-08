{ ... }:
{
  modules.user-manager.users = {
    lukebfox = {
      homeDirectory = "/home/lukebfox";
      home = ../../../../configs/home-manager/standard.nix;
      isAdmin = true;
      uid = 1000;
    };
  };
}
