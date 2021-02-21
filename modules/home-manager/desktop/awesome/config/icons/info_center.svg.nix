{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-info_center" ''
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
   enable-background="new 0 0 374.706 374.706"
   height="240"
   viewBox="0 0 175.64344 175.64344"
   width="240"
   class=""
   version="1.1"
   sodipodi:docname="notification.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
  <metadata
     id="metadata16">
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
     id="defs14" />
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
     id="namedview12"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="0.4609375"
     inkscape:cx="256"
     inkscape:cy="256"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="Capa_1" />
  <g
     id="g9"
     transform="matrix(0.38752239,0,0,0.38752239,14.249432,12.505775)">
    <path
       id="path-1_59_"
       d="m 80.294,53.529 h 294.412 v 53.529 H 80.294 Z"
       transform="translate(4,3)"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       d="m 80.294,160.588 h 267.647 v 53.529 H 80.294 Z"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       id="path3"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       id="path-1_58_"
       d="m 80.294,267.647 h 294.412 v 53.529 H 80.294 Z"
       transform="translate(4,11)"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       id="path-2_11_"
       d="m 0,53.529 h 53.529 v 53.529 H 0 Z"
       transform="translate(1,3)"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       id="path-2_10_"
       d="m 0,160.588 h 53.529 v 53.529 H 0 Z"
       transform="translate(1,7)"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
    <path
       id="path-2_9_"
       d="m 0,267.647 h 53.529 v 53.529 H 0 Z"
       transform="translate(1,11)"
       data-original="#000000"
       class="active-path"
       data-old_color="#000000"
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex}" />
  </g>
</svg>
''
