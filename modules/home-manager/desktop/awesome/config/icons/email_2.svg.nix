{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-email_2" ''
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
   sodipodi:docname="email-2.svg"
   inkscape:version="1.0 (4035a4fb49, 2020-05-01)">
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
       id="rect887"
       height="76.821962"
       width="72.691548"
       y="140.43247"
       x="160.68127" />
    <rect
       id="rect881"
       height="42.253372"
       width="57.559134"
       y="165.94589"
       x="180.14568" />
  </defs>
  <sodipodi:namedview
     inkscape:document-rotation="0"
     pagecolor="#000000"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0.65098039"
     inkscape:pageshadow="2"
     inkscape:window-width="1321"
     inkscape:window-height="740"
     id="namedview6"
     showgrid="false"
     inkscape:pagecheckerboard="false"
     inkscape:zoom="2.2645626"
     inkscape:cx="118.93231"
     inkscape:cy="121.34259"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="g877" />
  <g
     id="g877">
    <g
       id="g854">
      <path
         d="M 200,40 H 40 C 28.95,40 20.1,48.95 20.1,60 L 20,180 c 0,11.05 8.95,20 20,20 h 160 c 11.05,0 20,-8.95 20,-20 V 60 c 0,-11.05 -8.95,-20 -20,-20 z m 0,40 -80,50 L 40,80 V 60 l 80,50 80,-50 z"
         id="path2"
         style="opacity:0.8;fill:#ffffff;fill-opacity:1;stroke-width:5" />
      <text
         xml:space="preserve"
         id="text879"
         style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;white-space:pre;shape-inside:url(#rect881);fill:#000000;fill-opacity:1;stroke:none;" />
      <g
         id="g846">
        <ellipse
           id="ellipse16"
           ry="40.319271"
           rx="40.343189"
           cy="176.31927"
           cx="196.3432"
           style="fill:#e04f5f;stroke-width:0.427111" />
        <g
           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:64px;line-height:1.25;font-family:'sf pro d';-inkscape-font-specification:'sf pro d';letter-spacing:0px;word-spacing:0px;white-space:pre;shape-inside:url(#rect887);fill:#000000;fill-opacity:1;stroke:none"
           id="text885"
           transform="translate(0,-0.98869551)"
           aria-label="2">
          <path
             id="path840"
             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'SF Pro Display';-inkscape-font-specification:'SF Pro Display Bold';text-align:center;text-anchor:middle;fill:#ffffff"
             d="m 180.38672,168.12047 h 8.75 c 0,-4.34375 3.40625,-7.375 7.90625,-7.375 4.0625,0 6.84375,2.75 6.84375,6.375 0,3.125 -1.28125,5.28125 -7,10.78125 l -15.96875,15.125 v 6.46875 h 32.78125 v -7.5 h -20.4375 v -0.1875 l 9.46875,-9.0625 c 7.625,-7.28125 10.34375,-10.6875 10.34375,-16.21875 0,-7.5 -6.375,-13.125 -16.03125,-13.125 -9.78125,0 -16.65625,6.03125 -16.65625,14.71875 z" />
        </g>
      </g>
    </g>
  </g>
</svg>
''
