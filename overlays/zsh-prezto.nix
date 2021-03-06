final: prev:
{
  zsh-prezto = let
    # Include prezto-contrib modules for that sweet spaceship prompt!
    zsh-prezto-contrib = prev.fetchFromGitHub {
      owner  = "belak";
      repo   = "prezto-contrib";
      rev    = "2e2fc03c18a8960d3fb7f74a7a11f83f92b6bff3";
      sha256 = "18ig6b5c023iwv4i6dn1zd4gsfiyh953l3mzq3171v9qwf55myiw";
      fetchSubmodules = true;
    };
  in prev.zsh-prezto.overrideAttrs (old: {
    installPhase = old.installPhase + ''
      mkdir -p $out/share/zsh-prezto/contrib
      cp -R ${zsh-prezto-contrib}/* $out/share/zsh-prezto/contrib/
    '';
  });
}
