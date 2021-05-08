{ ... }:
{
  modules.user-manager.users = {
    "rokas.bagdonas" = {
      homeDirectory = "/home/rokas.bagdonas";
      isAdmin = true;
      uid = 1001;
    };
  };
}
