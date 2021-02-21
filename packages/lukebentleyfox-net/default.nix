{ pkgs, stdenv, ... }:
stdenv.mkDerivation {
  pname = "lukebentleyfox-net";
  version = "0.0.1";
  src = ./.;
  installPhase = "${pkgs.zola}/bin/zola build --output-dir $out";
}
