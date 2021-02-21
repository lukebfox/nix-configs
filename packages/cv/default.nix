{ pkgs, stdenv, lib, texlive }:

stdenv.mkDerivation {
  name = "lukebentleyfox-cv";
  src = ./.;
  buildInputs = [
    (texlive.combine {
      inherit (texlive)
        scheme-small

        # Add other LaTeX libraries (packages) here as needed, e.g:
        # stmaryrd amsmath pgf
        moderncv
        xpatch
        fontaxes
        fira
        fontawesome

        # build tools
        latexmk;
    })
  ];
  buildPhase = "make";

}
