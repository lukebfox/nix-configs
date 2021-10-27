{ stdenv }:
stdenv.mkDerivation {
  name = "templates";
  src = builtins.fetchGit {
    url = "https://github.com/lukebfox/templates.git";
    ref = "master";
    rev = "87c878d14159a49b3637d436a51217fefa365fb5";
    # see: https://github.com/NixOS/nix/pull/3166
    #fetchSubmodules = true;
  };
  installPhase = "cp -r $src $out";
}
