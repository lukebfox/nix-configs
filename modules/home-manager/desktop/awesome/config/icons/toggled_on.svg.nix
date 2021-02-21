{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-toggled_on" ''
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
   width="512"
   height="512"
   viewBox="0 0 135.46666 135.46667"
   version="1.1"
   id="svg853"
   inkscape:version="0.92.4 5da689c313, 2019-01-14"
   sodipodi:docname="toggled-on.svg">
  <defs
     id="defs847" />
  <sodipodi:namedview
     id="base"
     pagecolor="#252525"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="1"
     inkscape:pageshadow="2"
     inkscape:zoom="0.7"
     inkscape:cx="138.96628"
     inkscape:cy="255.71339"
     inkscape:document-units="mm"
     inkscape:current-layer="layer1"
     showgrid="false"
     units="px"
     inkscape:window-width="1321"
     inkscape:window-height="740"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0" />
  <metadata
     id="metadata850">
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
  <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(0,-161.53332)">
    <g
       id="g11"
       transform="translate(1.6833333e-6,-8.4666667)">
      <path
         style="fill:#8ab4ff;fill-opacity:0.94117647;stroke-width:2.20012879"
         d="m 33.066693,269.01082 h 69.333277 c 16.72673,0 30.33336,-14.03017 30.33336,-31.27746 0,-17.24737 -13.60663,-31.27754 -30.33336,-31.27754 H 33.066693 c -16.72672,0 -30.3333597,14.03017 -30.3333597,31.27754 0,17.24729 13.6066397,31.27746 30.3333597,31.27746 z m 69.333277,-53.61859 c 11.94707,0 21.66673,10.0222 21.66673,22.34113 0,12.31885 -9.71966,22.34105 -21.66673,22.34105 -11.946977,0 -21.666637,-10.0222 -21.666637,-22.34105 0,-12.31893 9.71966,-22.34113 21.666637,-22.34113 z"
         id="path6"
         inkscape:connector-curvature="0" />
      <ellipse
         ry="22.329439"
         rx="21.773804"
         cy="237.71442"
         cx="102.37249"
         id="path1490"
         style="opacity:1;fill:#${theme.base07-hex};fill-opacity:1;stroke-width:0.59941393" />
    </g>
  </g>
</svg>
''
