{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-airplane_mode" ''
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
   sodipodi:docname="ic_airplanemode_active_48px.svg"
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
     inkscape:cx="-51.304834"
     inkscape:cy="18.788525"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg6" />
  <path
     d="M 120,120"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#ffffff;fill-opacity:1;stroke-width:5" />
  <path
     d="M 215,160 V 140 L 135,90 V 35 c 0,-8.3 -6.7,-15 -15,-15 -8.3,0 -15,6.7 -15,15 v 55 l -80,50 v 20 l 80,-25 v 55 l -20,15 v 15 l 35,-10 35,10 v -15 l -20,-15 v -55 z"
     id="path4"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:5" />
</svg>
''
