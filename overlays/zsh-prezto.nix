final: prev:
{
  zsh-prezto =
    let
      # Include prezto-contrib modules for that sweet spaceship prompt!
      zsh-prezto-contrib = prev.fetchFromGitHub {
        owner = "belak";
        repo = "prezto-contrib";
        rev = "7ba7d42f92b90e5755763f6fe617d63dd1752019";
        sha256 = "sha256-3jbbgBZk2CneaKkxaGB9BvU7sXxWr1+uDVTqh2w0cSM=";
        fetchSubmodules = true;
      };
    in
    prev.zsh-prezto.overrideAttrs (old: {
      installPhase = old.installPhase + ''
        mkdir -p $out/share/zsh-prezto/contrib
        cp -R ${zsh-prezto-contrib}/* $out/share/zsh-prezto/contrib/
      '';
    });
}
