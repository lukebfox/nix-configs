{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wired_off" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="240"
   height="240"
   viewBox="0 0 240 240"
   version="1.1"
   id="svg4"
   sodipodi:docname="wired-alert.svg"
   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)">
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
     inkscape:zoom="1.7383042"
     inkscape:cx="84.551561"
     inkscape:cy="104.10598"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="M 201.81818,29.090909 H 38.181818 C 28.136364,29.090909 20,37.227273 20,47.272727 V 156.36364 c 0,10.04545 8.136364,18.18181 18.181818,18.18181 h 63.636362 l -18.181816,27.27273 v 9.09091 h 72.727276 v -9.09091 l -18.18182,-27.27273 h 63.63636 C 211.86364,174.54545 220,166.40909 220,156.36364 V 47.272727 c 0,-10.045454 -8.13636,-18.181818 -18.18182,-18.181818 z m 0,109.090911 H 38.181818 V 47.272727 H 201.81818 Z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:0.40000001;stroke-width:4.5454545" />
</svg>
''
