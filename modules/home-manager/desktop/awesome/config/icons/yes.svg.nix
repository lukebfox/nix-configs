{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-yes" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   inkscape:version="1.0 (4035a4fb49, 2020-05-01)"
   sodipodi:docname="yes.svg"
   id="svg8"
   version="1.1"
   height="240"
   width="240">
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
     inkscape:current-layer="svg8"
     inkscape:window-maximized="0"
     inkscape:window-y="28"
     inkscape:window-x="0"
     inkscape:cy="15.779816"
     inkscape:cx="-20.020499"
     inkscape:zoom="8.4399874"
     inkscape:pagecheckerboard="true"
     showgrid="false"
     id="namedview10"
     inkscape:window-height="692"
     inkscape:window-width="1366"
     inkscape:pageshadow="2"
     inkscape:pageopacity="0"
     guidetolerance="10"
     gridtolerance="10"
     objecttolerance="10"
     borderopacity="1"
     bordercolor="#666666"
     pagecolor="#ffffff" />
  <g
     id="g6"
     transform="matrix(12.5,0,0,12.5,20,-12934.5)">
    <rect
       id="rect2"
       fill="#${theme.base0B-hex}"
       transform="matrix(0,-1,-1,0,0,0)"
       ry="3"
       rx="3.0020001"
       y="-16"
       x="-1052.36"
       height="16"
       width="16" />
    <path
       id="path4"
       fill="#${theme.base07-hex}"
       d="m 12.658,1039.878 -5.658,5.656 -2.828,-2.828 -1.414,1.414 2.828,2.828 1.414,1.414 1.414,-1.414 5.658,-5.656 z" />
  </g>
</svg>
''
