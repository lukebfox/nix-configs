{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.themes.base16;
  templates = importJSON ./templates.json;
  schemes = importJSON ./schemes.json;

  # The theme yaml files only supply 16 hex values, but the templates take
  # a transformation of this data such as rgb. The hacky python script pre-
  # processes the theme file in this way for consumption by the mustache
  # engine below.
  python = pkgs.python3.withPackages (ps: [ ps.pyyaml ]);
  loadyaml = {src, name ? "yaml"}:
    importJSON (pkgs.stdenv.mkDerivation {
      inherit name src;
      builder = pkgs.writeText "builder.sh" ''
            slug_all=$(${pkgs.coreutils}/bin/basename $src)
            slug=''${slug_all%.*}
            ${python}/bin/python ${./base16writer.py} $slug < $src > $out
          '';
      allowSubstitutes = false;  # will never be in cache
    }); 
  
  # Returns an attrset of theme data for the chosen base16 scheme and variant.
  theme = loadyaml {
    src = "${pkgs.fetchgit (schemes."${cfg.scheme}")}/${cfg.variant}.yaml";
  };

  # Returns the store path of the source file for a given base16 template.
  # Use the colors-only template if one exists, as this leaves the option
  # to add your own customisations.
  template = name:
    let templateDir = "${pkgs.fetchgit (templates."${name}")}/templates";
    in  if pathExists (templateDir + "/colors.mustache")
        then templateDir + "/colors.mustache"
        else templateDir + "/default.mustache";

  # Mustache engine. Applies any theme to any template, providing they are
  # included in the local json source files.
  mustache = template-attrs: name: src:
    pkgs.stdenv.mkDerivation {
      name = "${name}-${template-attrs.scheme-slug}";
      data = pkgs.writeText "${name}-data" (builtins.toJSON template-attrs);
      inherit src;
      phases = [ "buildPhase" ];
      buildPhase = "${pkgs.mustache-go}/bin/mustache $data $src > $out";
      allowSubstitutes = false;  # will never be in cache
    };

in
{
  options.themes.base16 = {
    enable = mkEnableOption "Base 16 Color Schemes";
    scheme = mkOption {
      type = types.str;
      default = "tomorrow";
    };
    variant = mkOption {
      type = types.str;
      default = "tomorrow";
    };
    extraParams = mkOption {
      type = types.attrsOf types.str;
      default = {};
    };
  };
  
  config.lib.base16 = {
    theme = theme // cfg.extraParams;
    base16template = repo:
      mustache (theme // cfg.extraParams) repo (template repo);
    template = attrs@{name ? "unknown-template", src , ...}:
      mustache (theme// cfg.extraParams // attrs) name src;
  };

}
