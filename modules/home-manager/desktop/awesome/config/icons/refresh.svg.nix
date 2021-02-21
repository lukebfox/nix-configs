{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-refresh" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   width="240"
   height="240"
   viewBox="0 0 240 240"
   id="svg4"
   sodipodi:docname="refresh.svg"
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
     inkscape:zoom="0.98333333"
     inkscape:cx="-197.28814"
     inkscape:cy="120"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="m 120.41073,55.11156 c 21.68655,0 42.34041,8.26155 57.83081,23.75194 32.01348,32.01348 32.01348,84.68083 0,116.69431 -18.58848,19.62117 -44.4058,26.85002 -69.19044,23.75194 l 5.16347,-20.65386 c 17.55578,2.06538 36.14425,-4.13077 49.56926,-17.55578 23.75194,-23.75194 23.75194,-62.99428 0,-87.77891 C 152.42421,81.96158 135.90112,75.76542 120.41073,75.76542 V 123.2693 L 68.776078,71.63465 120.41073,20 V 55.11156 M 61.547227,195.55781 C 34.697209,168.70779 30.566437,127.40007 49.154911,95.38659 l 15.490395,15.49039 c -11.359623,22.71925 -7.228851,51.63465 12.392316,70.22313 5.163465,5.16346 11.359623,9.29423 18.588475,12.39231 l -6.196159,20.65386 C 79.103008,210.01551 69.808771,203.81935 61.547227,195.55781 Z"
     id="path2"
     inkscape:connector-curvature="0"
     style="fill:#${theme.base07-hex};stroke-width:10.32693005" />
</svg>
''
