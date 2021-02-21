{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-power" ''
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
   sodipodi:docname="power.svg"
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
     inkscape:cx="-267.45763"
     inkscape:cy="69.564407"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="m 173.64706,48.70588 -17.05882,17.05883 c 20.35293,12.35294 33.99999,34.58823 33.99999,60.11764 A 70.588235,70.588235 0 0 1 120,196.47059 70.588235,70.588235 0 0 1 49.41177,125.88235 c 0,-25.52941 13.647059,-47.7647 33.882353,-60.23529 L 66.352946,48.70588 C 41.882358,65.64706 25.882358,93.88235 25.882358,125.88235 A 94.117647,94.117647 0 0 0 120,220 94.117647,94.117647 0 0 0 214.11764,125.88235 c 0,-32 -16,-60.23529 -40.47058,-77.17647 M 131.7647,20 h -23.52941 v 117.64706 h 23.52941"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};stroke-width:11.76470661" />
</svg>
''
