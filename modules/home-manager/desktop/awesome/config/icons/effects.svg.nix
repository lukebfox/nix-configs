{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-effects" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   id="Capa_1"
   enable-background="new 0 0 488.471 488.471"
   height="240"
   viewBox="0 0 240 240"
   width="240"
   class=""
   version="1.1"
   sodipodi:docname="effects.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
  <metadata
     id="metadata17">
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
     id="defs15" />
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
     id="namedview13"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="0.4609375"
     inkscape:cx="-523.03664"
     inkscape:cy="256"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="Capa_1"
     scale-x="1" />
  <g
     transform="matrix(0.40944089,0,0,0.40944089,20,20)"
     id="g10">
    <path
       d="m 427.412,122.118 c 0,-33.723 27.337,-61.059 61.059,-61.059 -33.721,0 -61.059,-27.337 -61.059,-61.059 0,33.721 -27.337,61.059 -61.059,61.059 33.721,0 61.059,27.335 61.059,61.059 z"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       id="path2"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       d="m 442.677,183.176 c 0,25.291 -20.503,45.794 -45.794,45.794 25.292,0 45.794,20.503 45.794,45.794 0,-25.292 20.503,-45.794 45.794,-45.794 -25.292,0.001 -45.794,-20.502 -45.794,-45.794 z"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       id="path4"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       d="m 213.706,183.176 c 0,-50.583 41.005,-91.588 91.588,-91.588 -50.583,0 -91.588,-41.005 -91.588,-91.588 0,50.583 -41.005,91.588 -91.588,91.588 50.583,0 91.588,41.006 91.588,91.588 z"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       id="path6"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       d="M 335.824,91.588 0,427.412 61.059,488.471 396.883,152.647 Z m -52.115,97.909 43.17,-43.17 15.265,15.265 -43.17,43.17 c 0,0 -15.265,-15.265 -15.265,-15.265 z"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       id="path8"
       inkscape:connector-curvature="0"
       style="fill:#{theme.base07-hex}" />
  </g>
</svg>
''
