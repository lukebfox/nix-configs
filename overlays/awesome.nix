final: prev:
{
  # More recent awesomewm (13/10/20), with gtk support.
  awesome =
    (prev.awesome.overrideAttrs (_: {
      src = prev.fetchFromGitHub {
        owner = "awesomewm";
        repo = "awesome";
        rev = "cc67a5b40bcd461a3ed3e955da8409219b11efcf"; 
        sha256 = "15cas610psik838rnqdj306g8ys69i96q3c8cda384yvk9i979s7";
      };
    })).override {
      gtk3Support = true;
      gtk3 = final.gtk3;
      luaPackages = final.lua53Packages;
    };
}
