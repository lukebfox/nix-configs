final: prev:
let
  inherit (prev) callPackage;
in
{
  # My blog and cv :)
  blog = callPackage ./lukebentleyfox-net { };
  cv = callPackage ./cv { };

  # Useful templates for developers.
  #templates = callPackage ./templates {};

  # Subset of nerdfonts containing only a patched fira code font.
  firacode-nerdfont = callPackage ./firacode-nerdfont { };

  # Gnome stuff
  whitesur-gnome = callPackage ./whitesur-gnome { }; # shell theme
  dash-to-dock = callPackage ./dash-to-dock { }; # '41 extension
}
