{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wired_alert" ''
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
   sodipodi:docname="wired-alert.svg"
   id="svg4"
   version="1.1"
   viewBox="0 0 240 240"
   height="240"
   width="240">
  <metadata
     id="metadata10">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs
     id="defs8" />
  <sodipodi:namedview
     inkscape:document-rotation="0"
     inkscape:current-layer="svg4"
     inkscape:window-maximized="0"
     inkscape:window-y="28"
     inkscape:window-x="45"
     inkscape:cy="132.09498"
     inkscape:cx="182.153"
     inkscape:zoom="1.9765685"
     inkscape:pagecheckerboard="true"
     showgrid="false"
     id="namedview6"
     inkscape:window-height="740"
     inkscape:window-width="1321"
     inkscape:pageshadow="2"
     inkscape:pageopacity="0"
     guidetolerance="10"
     gridtolerance="10"
     objecttolerance="10"
     borderopacity="1"
     bordercolor="#666666"
     pagecolor="#ffffff" />
  <path
     d="M 38.181641 29.091797 C 28.136187 29.091797 20 37.227983 20 47.273438 L 20 156.36328 C 20 166.40873 28.136187 174.54492 38.181641 174.54492 L 101.81836 174.54492 L 83.636719 201.81836 L 83.636719 210.9082 L 156.36328 210.9082 L 156.36328 201.81836 L 138.18164 174.54492 L 166.98633 174.54492 L 166.98633 138.18164 L 38.181641 138.18164 L 38.181641 47.273438 L 201.81836 47.273438 L 201.81836 81.871094 L 220 81.871094 L 220 47.273438 C 220 37.227984 211.86382 29.091797 201.81836 29.091797 L 38.181641 29.091797 z "
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:4.5454545"
     id="path2" />
  <path
     d="m 187,211.03998 h 18.50666 V 192.53333 H 187 Z M 187,100 v 74.02666 h 18.50666 V 100 Z"
     id="path6"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:9.25333"
     sodipodi:nodetypes="cccccccccc" />
</svg>
''
