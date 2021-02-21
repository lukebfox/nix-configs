{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-email_5" ''
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
   sodipodi:docname="email-5.svg"
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
     id="defs8">
    <rect
       x="160.68127"
       y="140.43247"
       width="72.691548"
       height="76.821962"
       id="rect887" />
    <rect
       x="180.14568"
       y="165.94589"
       width="57.559134"
       height="42.253372"
       id="rect881" />
  </defs>
  <sodipodi:namedview
     inkscape:current-layer="g844"
     inkscape:window-maximized="0"
     inkscape:window-y="28"
     inkscape:window-x="45"
     inkscape:cy="121.34259"
     inkscape:cx="118.93231"
     inkscape:zoom="2.2645626"
     inkscape:pagecheckerboard="false"
     showgrid="false"
     id="namedview6"
     inkscape:window-height="740"
     inkscape:window-width="1321"
     inkscape:pageshadow="2"
     inkscape:pageopacity="0.65098039"
     guidetolerance="10"
     gridtolerance="10"
     objecttolerance="10"
     borderopacity="1"
     bordercolor="#666666"
     pagecolor="#000000"
     inkscape:document-rotation="0" />
  <g
     id="g877">
    <g
       id="g853">
      <path
         style="opacity:0.8;fill:#ffffff;fill-opacity:1;stroke-width:5"
         id="path2"
         d="M 200,40 H 40 C 28.95,40 20.1,48.95 20.1,60 L 20,180 c 0,11.05 8.95,20 20,20 h 160 c 11.05,0 20,-8.95 20,-20 V 60 c 0,-11.05 -8.95,-20 -20,-20 z m 0,40 -80,50 L 40,80 V 60 l 80,50 80,-50 z" />
      <text
         style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;white-space:pre;shape-inside:url(#rect881);fill:#000000;fill-opacity:1;stroke:none;"
         id="text879"
         xml:space="preserve" />
      <g
         id="g844">
        <ellipse
           style="fill:#e04f5f;stroke-width:0.427111"
           cx="196.3432"
           cy="176.31927"
           rx="40.343189"
           ry="40.319271"
           id="ellipse16" />
        <g
           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:64px;line-height:1.25;font-family:'sf pro d';-inkscape-font-specification:'sf pro d';letter-spacing:0px;word-spacing:0px;white-space:pre;shape-inside:url(#rect887);fill:#000000;fill-opacity:1;stroke:none"
           id="text885"
           transform="translate(0,-0.98869551)"
           aria-label="5">
          <path
             id="path842"
             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'SF Pro Display';-inkscape-font-specification:'SF Pro Display Bold';text-align:center;text-anchor:middle;fill:#ffffff"
             d="m 197.52734,200.49547 c 10.34375,0 17.4375,-6.46875 17.4375,-16 0,-8.59375 -6.15625,-14.78125 -14.75,-14.78125 -4.5625,0 -8.28125,1.84375 -10.15625,4.875 h -0.1875 l 1.09375,-12.6875 h 21.28125 v -7.5 h -28.78125 l -2.0625,26.46875 h 8.21875 c 1.53125,-2.71875 4.34375,-4.40625 7.96875,-4.40625 4.9375,0 8.375,3.40625 8.375,8.25 0,4.90625 -3.4375,8.3125 -8.40625,8.3125 -4.34375,0 -7.6875,-2.5625 -8.21875,-6.46875 h -8.71875 c 0.25,8.1875 7.25,13.9375 16.90625,13.9375 z" />
        </g>
      </g>
    </g>
  </g>
</svg>
''
