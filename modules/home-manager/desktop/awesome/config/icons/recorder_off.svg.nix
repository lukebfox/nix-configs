{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-recorder_off" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="240mm"
   height="240mm"
   viewBox="0 0 240 240"
   version="1.1"
   id="svg906"
   inkscape:version="0.92.4 5da689c313, 2019-01-14"
   sodipodi:docname="recorder-off.svg">
  <defs
     id="defs900" />
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="0.35"
     inkscape:cx="721.80219"
     inkscape:cy="560"
     inkscape:document-units="mm"
     inkscape:current-layer="layer1"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:window-width="1321"
     inkscape:window-height="740"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0" />
  <metadata
     id="metadata903">
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
  <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(0,-57)">
    <path
       style="fill:#${theme.base07-hex};fill-opacity:1;fill-rule:evenodd;stroke-width:0.97626179"
       d="M 453.54297 75.589844 A 377.95276 377.95276 0 0 0 75.589844 453.54297 A 377.95276 377.95276 0 0 0 453.54297 831.49609 A 377.95276 377.95276 0 0 0 831.49609 453.54297 A 377.95276 377.95276 0 0 0 453.54297 75.589844 z M 453.54297 179.52734 C 604.43002 179.52734 727.55859 302.65591 727.55859 453.54297 C 727.55859 604.43002 604.43002 727.55859 453.54297 727.55859 C 302.65592 727.55859 179.52734 604.43002 179.52734 453.54297 C 179.52734 302.65591 302.65592 179.52734 453.54297 179.52734 z M 453.54297 255.11719 C 343.50809 255.11719 255.11719 343.50807 255.11719 453.54297 C 255.11719 563.57787 343.50809 651.96875 453.54297 651.96875 C 563.57787 651.96875 651.96875 563.57787 651.96875 453.54297 C 651.96875 343.50807 563.57787 255.11719 453.54297 255.11719 z "
       transform="matrix(0.26458333,0,0,0.26458333,0,57)"
       id="path1456" />
  </g>
</svg>
''
