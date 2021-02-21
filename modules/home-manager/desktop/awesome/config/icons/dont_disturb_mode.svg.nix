{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-dont_disturb_mode" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   height="512px"
   viewBox="-12 0 448 448.04455"
   width="512px"
   version="1.1"
   id="svg6"
   sodipodi:docname="dont-disturb-mode.svg"
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
     pagecolor="#252525"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="1"
     inkscape:pageshadow="2"
     inkscape:window-width="1321"
     inkscape:window-height="738"
     id="namedview8"
     showgrid="false"
     inkscape:zoom="0.4609375"
     inkscape:cx="264.67797"
     inkscape:cy="247.32203"
     inkscape:window-x="45"
     inkscape:window-y="30"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg6" />
  <g
     id="g4"
     transform="matrix(0.71799041,0,0,0.71799041,59.727137,63.17728)">
    <path
       d="m 224.02344,448.03125 c 85.71484,0.90234 164.01172,-48.48828 200.11718,-126.23047 -22.72265,9.91406 -47.33203,14.76953 -72.11718,14.23047 -97.15625,-0.10938 -175.89063,-78.84375 -176,-176 C 176.99609,94.3125 213.25781,34.199219 270.93359,2.679688 255.37891,0.699219 239.70312,-0.1875 224.02344,0.03125 c -123.71485,0 -224.0000025,100.28906 -224.0000025,224 0,123.71484 100.2851525,224 224.0000025,224 z m 0,0"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       style="fill:#${theme.base07-hex}"
       data-darkreader-inline-fill=""
       id="path2"
       inkscape:connector-curvature="0" />
  </g>
</svg>
''
