final: prev:
let
  inherit (prev) callPackage;
  inherit (prev.lib) recursiveUpdate;
in
{
  # My blog and cv :)
  blog = callPackage ./lukebentleyfox-net { };
  cv = callPackage ./cv { };

  # Useful templates for developers.
  #templates = callPackage ./templates {};

  # Subset of nerdfonts containing only a patched fira code font.
  firacode-nerdfont = callPackage ./firacode-nerdfont { };

  whitesur-gnome = callPackage ./whitesur-gnome { };
  gnomeExtensions = recursiveUpdate prev.gnomeExtensions { dash-to-dock = callPackage ./dash-to-dock { }; };
}
