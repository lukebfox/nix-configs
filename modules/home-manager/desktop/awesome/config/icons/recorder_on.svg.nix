{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-recorder_on" ''
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
   sodipodi:docname="recorder-on.svg">
  <defs
     id="defs900" />
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="0.60460731"
     inkscape:cx="560.72303"
     inkscape:cy="505.04802"
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
    <g
       id="g882">
      <path
         id="path858"
         transform="matrix(0.26458333,0,0,0.26458333,0,57)"
         d="M 453.54297 75.589844 A 377.95276 377.95276 0 0 0 75.589844 453.54297 A 377.95276 377.95276 0 0 0 453.54297 831.49609 A 377.95276 377.95276 0 0 0 831.49609 453.54297 A 377.95276 377.95276 0 0 0 453.54297 75.589844 z M 453.54297 170.07812 C 609.53654 170.07813 737.00781 297.54939 737.00781 453.54297 C 737.00781 609.53654 609.53654 737.00781 453.54297 737.00781 C 297.5494 737.00781 170.07812 609.53654 170.07812 453.54297 C 170.07812 297.54939 297.5494 170.07812 453.54297 170.07812 z "
         style="fill:#${theme.base07-hex};fill-opacity:1;fill-rule:evenodd;stroke-width:0.97626179" />
      <path
         inkscape:connector-curvature="0"
         id="path1456"
         d="m 120,126.99995 c -27.762298,0 -50.000048,22.23776 -50.000048,50.00006 0,27.7623 22.23775,50.00004 50.000048,50.00004 27.7623,0 50.00005,-22.23774 50.00005,-50.00004 0,-27.7623 -22.23775,-50.00006 -50.00005,-50.00006 z"
         style="fill:#${theme.base08-hex};fill-opacity:1;fill-rule:evenodd;stroke-width:0.2583026" />
    </g>
  </g>
</svg>
''
