{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_2_alert" ''
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
   id="svg8"
   sodipodi:docname="wifi-strength-2-alert.svg"
   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)">
  <metadata
     id="metadata14">
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
     id="defs12" />
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
     id="namedview10"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="4.9166667"
     inkscape:cx="69.967175"
     inkscape:cy="30.177599"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg8" />
  <g
     id="g832"
     transform="matrix(1.7907692,0,0,1.7907692,0.7200004,-384.29538)">
    <path
       style="fill:none"
       inkscape:connector-curvature="0"
       id="path2"
       d="m 0,216 h 26 v 24 H 0 Z" />
    <path
       style="fill:#${theme.base07-hex};fill-opacity:0.4"
       inkscape:connector-curvature="0"
       id="path4"
       d="m 24.24,224 1.35,-1.68 C 25.1,221.96 20.26,218 13,218 5.74,218 0.9,221.96 0.42,222.32 L 12.99,237.98 13,238 13.01,237.99 20,229.28 V 224 Z" />
    <path
       style="fill:#${theme.base07-hex};fill-opacity:1"
       inkscape:connector-curvature="0"
       id="path6"
       d="m 5.45,228.59 7.54,9.4 0.01,0.01 0.01,-0.01 6.99,-8.71 v -1.09 C 18.93,227.46 16.41,226 13,226 c -4.36,0 -7.26,2.38 -7.55,2.59 z M 22,226 v 8 h 2 v -8 z m 0,12 h 2 v -2 h -2 z" />
  </g>
</svg>
''
