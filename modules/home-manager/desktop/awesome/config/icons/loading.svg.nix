{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-loading" ''
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
   sodipodi:docname="ic_sync_48px.svg"
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
     inkscape:zoom="0.61458333"
     inkscape:cx="-276.66458"
     inkscape:cy="-76.310045"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="M 120,47.272727 V 20 L 83.636361,56.363636 120,92.72727 V 65.454545 c 30.13636,0 54.54545,24.409095 54.54545,54.545455 0,9.22727 -2.31818,17.86364 -6.31818,25.5 l 13.27272,13.27273 C 188.54545,147.5 192.72727,134.27273 192.72727,120 192.72727,79.818182 160.18181,47.272727 120,47.272727 Z m 0,127.272723 c -30.136366,0 -54.545457,-24.40909 -54.545457,-54.54545 0,-9.22727 2.318182,-17.86364 6.318182,-25.5 L 58.499998,81.227273 C 51.454543,92.5 47.272725,105.72727 47.272725,120 c 0,40.18182 32.545455,72.72727 72.727275,72.72727 V 220 L 156.36363,183.63636 120,147.27273 Z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:4.5454545" />
</svg>
''
