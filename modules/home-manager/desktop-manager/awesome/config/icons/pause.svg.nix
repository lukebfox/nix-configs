{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-pause" ''
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
   viewBox="0 0 240.00001 240"
   version="1.1"
   id="svg4"
   sodipodi:docname="ic_pause_48px.svg"
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
     units="px"
     width="240mm"
     inkscape:zoom="0.30729167"
     inkscape:cx="-372.98936"
     inkscape:cy="-268.78861"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="m 34.285715,220 h 57.14286 V 20 H 34.285715 Z M 148.57142,20 v 200 h 57.14287 V 20 Z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:7.1428566" />
</svg>
''
