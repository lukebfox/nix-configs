{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_4_alert" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="48"
   height="48"
   viewBox="0 0 48 48"
   version="1.1"
   id="svg6"
   sodipodi:docname="wifi-strength-4-alert.svg"
   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)">
  <metadata
     id="metadata12">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs10" />
  <sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1321"
     inkscape:window-height="740"
     id="namedview8"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="0.43457604"
     inkscape:cx="16.852347"
     inkscape:cy="388.12021"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg6" />
  <path
     d="m 40.639143,42.498211 h 3.699641 V 38.79857 H 40.639143 Z M 23.990751,5.5017888 C 10.561049,5.5017888 1.607914,12.827078 0.72,13.493014 l 23.252253,28.9682 0.01851,0.037 0.01851,-0.01851 12.93025,-16.111943 v -9.767054 h 7.843241 L 47.28,13.493014 C 46.373589,12.827078 37.420452,5.5017888 23.990751,5.5017888 Z M 40.639143,35.098926 h 3.699641 v -14.79857 h -3.699641 z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:1.84982121" />
</svg>
''
