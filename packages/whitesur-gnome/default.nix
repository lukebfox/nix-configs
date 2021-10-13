{ stdenv, lib, ... }:
stdenv.mkDerivation {
  name = "whitesur-shell-theme";
  src = ./WhiteSur-light;
  installPhase = ''
    cp -r $src $out/
  '';
}
