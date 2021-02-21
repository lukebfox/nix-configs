{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-battery_charging_10" ''
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
   id="svg6"
   sodipodi:docname="battery-charging-10.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
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
     inkscape:zoom="1.2291667"
     inkscape:cx="104.49589"
     inkscape:cy="142.20093"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg6" />
  <g
     id="g827"
     transform="matrix(5,0,0,5,-0.025,-960)">
    <g
       transform="translate(0,192)"
       id="g833">
      <path
         inkscape:connector-curvature="0"
         d="m 22,40 v -6 h -8 v 7.33 C 14,42.8 15.19,44 16.67,44 h 14.67 c 1.47,0 2.67,-1.19 2.67,-2.67 V 34 h -8.8 z"
         id="path2"
         style="fill:#${theme.base07-hex};fill-opacity:0.4" />
      <path
         inkscape:connector-curvature="0"
         d="M 31.33,8 H 28 V 4 H 20 V 8 H 16.67 C 15.19,8 14,9.19 14,10.67 V 34 h 8 v -5 h -4 l 8,-15 v 11 h 4 l -4.8,9 H 34 V 10.67 C 34,9.19 32.81,8 31.33,8 Z"
         id="path4"
         style="fill:#${theme.base07-hex};fill-opacity:0.4" />
    </g>
    <path
       style="fill:#${theme.base07-hex}f;fill-opacity:1"
       id="path2-3"
       d="m 22,232 v -6 h -8 v 7.33 c 0,1.47 1.19,2.67 2.67,2.67 h 14.67 c 1.47,0 2.67,-1.19 2.67,-2.67 V 226 h -8.8 z"
       inkscape:connector-curvature="0" />
  </g>
</svg>
''
