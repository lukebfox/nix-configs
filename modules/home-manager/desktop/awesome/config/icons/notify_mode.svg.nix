{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-notify_mode" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   height="512px"
   viewBox="-21 0 512 512"
   width="512px"
   version="1.1"
   id="svg12"
   sodipodi:docname="notify-mode.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
  <metadata
     id="metadata18">
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
     id="defs16" />
  <sodipodi:namedview
     pagecolor="#252525"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="1"
     inkscape:pageshadow="2"
     inkscape:window-width="1321"
     inkscape:window-height="738"
     id="namedview14"
     showgrid="false"
     inkscape:zoom="0.4609375"
     inkscape:cx="-98.711864"
     inkscape:cy="256"
     inkscape:window-x="45"
     inkscape:window-y="30"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg12" />
  <g
     id="g10"
     transform="matrix(0.75500702,0,0,0.75500702,57.825511,62.718203)">
    <path
       d="m 448,232.14844 c -11.77734,0 -21.33203,-9.55469 -21.33203,-21.33203 0,-59.83985 -23.29688,-116.074222 -65.60156,-158.402348 -8.33985,-8.339843 -8.33985,-21.820312 0,-30.164062 8.33984,-8.339844 21.82421,-8.339844 30.16406,0 50.37109,50.367188 78.10156,117.33594 78.10156,188.56641 0,11.77734 -9.55469,21.33203 -21.33203,21.33203 z m 0,0"
       data-original="#000000"
       class="active-path"
       style="fill:#${theme.base07-hex}"
       data-darkreader-inline-fill=""
       data-old_color="#000000"
       id="path2"
       inkscape:connector-curvature="0" />
    <path
       d="M 21.332031,232.14844 C 9.558594,232.14844 0,222.59375 0,210.81641 0,139.58594 27.734375,72.617188 78.101562,22.25 c 8.339844,-8.339844 21.824219,-8.339844 30.164068,0 8.34375,8.34375 8.34375,21.824219 0,30.164062 C 65.960938,94.71875 42.667969,150.97656 42.667969,210.81641 c 0,11.77734 -9.558594,21.33203 -21.335938,21.33203 z m 0,0"
       data-original="#000000"
       class="active-path"
       style="fill:#${theme.base07-hex}"
       data-darkreader-inline-fill=""
       data-old_color="#000000"
       id="path4"
       inkscape:connector-curvature="0" />
    <path
       d="M 434.75391,360.8125 C 402.49609,333.54687 384,293.69531 384,251.47656 V 192 C 384,116.92969 328.23437,54.785156 256,44.375 V 21.332031 C 256,9.535156 246.44141,0 234.66797,0 222.89062,0 213.33203,9.535156 213.33203,21.332031 V 44.375 C 141.07812,54.785156 85.332031,116.92969 85.332031,192 v 59.47656 c 0,42.21875 -18.496093,82.07031 -50.941406,109.50391 -8.300781,7.10547 -13.058594,17.42969 -13.058594,28.35156 0,20.58984 16.746094,37.33594 37.335938,37.33594 H 410.66797 c 20.58594,0 37.33203,-16.7461 37.33203,-37.33594 0,-10.92187 -4.75781,-21.24609 -13.24609,-28.51953 z m 0,0"
       data-original="#000000"
       class="active-path"
       style="fill:#${theme.base07-hex}"
       data-darkreader-inline-fill=""
       data-old_color="#000000"
       id="path6"
       inkscape:connector-curvature="0" />
    <path
       d="m 234.66797,512 c 38.63281,0 70.95312,-27.54297 78.3789,-64 H 156.28906 c 7.42188,36.45703 39.74219,64 78.37891,64 z m 0,0"
       data-original="#000000"
       class="active-path"
       style="fill:#${theme.base07-hex}"
       data-darkreader-inline-fill=""
       data-old_color="#000000"
       id="path8"
       inkscape:connector-curvature="0" />
  </g>
</svg>
''
