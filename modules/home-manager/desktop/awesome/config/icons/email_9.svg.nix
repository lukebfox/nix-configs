{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-email_9" ''
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
   sodipodi:docname="email-99.svg"
   inkscape:version="1.0 (4035a4fb49, 2020-05-01)">
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
    <text
       style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;white-space:pre;shape-inside:url(#rect881);fill:#000000;fill-opacity:1;stroke:none;"
       id="text879"
       xml:space="preserve" />
    <g
       id="g891">
      <path
         d="M 200,40 H 40 C 28.95,40 20.1,48.95 20.1,60 L 20,180 c 0,11.05 8.95,20 20,20 h 160 c 11.05,0 20,-8.95 20,-20 V 60 c 0,-11.05 -8.95,-20 -20,-20 z m 0,40 -80,50 L 40,80 V 60 l 80,50 80,-50 z"
         id="path2"
         style="opacity:0.8;fill:#ffffff;fill-opacity:1;stroke-width:5" />
      <g
         id="g884">
        <ellipse
           id="ellipse16"
           ry="40.319271"
           rx="40.343189"
           cy="176.31927"
           cx="196.3432"
           style="fill:#e04f5f;stroke-width:0.427111" />
        <g
           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:61.3333px;line-height:1.25;font-family:'sf pro d';-inkscape-font-specification:'sf pro d';letter-spacing:0px;word-spacing:0px;white-space:pre;shape-inside:url(#rect887);fill:#000000;fill-opacity:1;stroke:none"
           id="text885"
           transform="translate(0,-0.98869551)"
           aria-label="9">
          <path
             id="path878"
             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-family:'SF Pro Display';-inkscape-font-specification:'SF Pro Display Bold';text-align:center;text-anchor:middle;fill:#ffffff"
             d="m 196.26367,197.99278 c 11.23047,0 18.02864,-8.62499 18.02864,-22.94009 0,-15.78255 -8.50521,-22.22134 -18.02864,-22.22134 -9.64322,0 -16.65103,6.3789 -16.65103,15.33332 0,8.41536 6.31901,14.10546 14.34504,14.10546 5.66016,0 9.94271,-2.8151 11.5,-7.00781 h 0.17969 c 0.0599,9.28385 -2.84506,15.57291 -9.34375,15.57291 -3.6237,0 -6.28906,-1.64713 -7.24739,-4.73177 h -8.92448 c 1.13802,7.00781 7.66667,11.88932 16.14192,11.88932 z m 0.03,-22.43098 c -4.52213,0 -7.8763,-3.23437 -7.8763,-7.7565 0,-4.3724 3.50391,-7.75651 7.96614,-7.75651 4.43229,0 7.9362,3.44401 7.9362,7.90625 0,4.43229 -3.47396,7.60676 -8.02604,7.60676 z" />
        </g>
      </g>
    </g>
  </g>
</svg>
''
