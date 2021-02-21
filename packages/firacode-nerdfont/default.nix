{ stdenv, lib, fetchzip }:

stdenv.mkDerivation rec {
  name = "firacode-nerdfont-${version}";
  version = "2.1.0";

  src = fetchzip {
    url =
      "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/FiraCode.zip";
    sha256 = "0k064h89ynbbqq5gvisng2s0h65ydnhr6wzx7hgaw8wfbc3qayvp";
    stripRoot = false;
  };
  buildCommand = ''
    install --target $out/share/fonts/opentype -D $src/*.ttf
  '';

  meta = with lib; {
    description = "Nerdfont version of Fira Code";
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
    maintainers = [ maintainers.lukebfox ];
    inherit version;
  };
}
