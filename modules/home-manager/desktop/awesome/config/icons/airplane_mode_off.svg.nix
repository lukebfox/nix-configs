{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-airplane_mode_off" ''
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
   sodipodi:docname="ic_airplanemode_inactive_48px.svg"
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
     inkscape:zoom="0.43457604"
     inkscape:cx="-392.6819"
     inkscape:cy="-33.781494"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="M 135,90 V 35 c 0,-8.3 -6.7,-15 -15,-15 -8.3,0 -15,6.7 -15,15 V 71.8 L 183.25,150.05 215,160 V 140 Z M 35,52.75 84.85,102.6 25,140 v 20 l 80,-25 v 55 l -20,15 v 15 l 35,-10 35,10 V 205 L 135,190 V 152.75 L 192.25,210 205,197.25 47.75,40 Z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:5" />
</svg>
''
