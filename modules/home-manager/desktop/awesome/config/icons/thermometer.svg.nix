{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-thermometer" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   width="240"
   height="240"
   viewBox="0 0 240 240"
   id="svg4"
   sodipodi:docname="thermometer.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
  <metadata
     id="metadata10">
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
     id="defs8" />
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
     id="namedview6"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="0.98333333"
     inkscape:cx="-142.32954"
     inkscape:cy="120"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="m 170,170 a 50,50 0 0 1 -50,50 50,50 0 0 1 -50,-50 c 0,-16.4 7.9,-30.9 20,-40 V 50 a 30,30 0 0 1 30,-30 30,30 0 0 1 30,30 v 80 c 12.1,9.1 20,23.6 20,40 M 110,80 v 61.7 C 98.3,145.8 90,156.9 90,170 a 30,30 0 0 0 30,30 30,30 0 0 0 30,-30 c 0,-13.1 -8.3,-24.2 -20,-28.3 V 80 Z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};stroke-width:10" />
</svg>
''
