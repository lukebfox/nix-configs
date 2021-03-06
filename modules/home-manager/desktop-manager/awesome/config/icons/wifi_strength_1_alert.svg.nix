{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_1_alert" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="48"
   height="48"
   viewBox="0 0 48 48"
   version="1.1"
   id="svg8"
   sodipodi:docname="wifi-strength-1-alert.svg"
   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)">
  <metadata
     id="metadata14">
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
     id="defs12" />
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
     id="namedview10"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="2.4583334"
     inkscape:cx="72.138642"
     inkscape:cy="106.67249"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg8" />
  <g
     id="g832"
     transform="matrix(0.23231214,0,0,0.23231214,-3.8774568,-3.8774563)">
    <path
       style="fill:none"
       inkscape:connector-curvature="0"
       id="path2"
       d="m 19.79,176.45967 h 26 v 24 h -26 z" />
    <path
       inkscape:connector-curvature="0"
       style="fill:#${theme.base07-hex};fill-opacity:0.4;stroke-width:7.9459672"
       id="path4"
       d="M 209.48294,87.216134 220.21,73.866904 c -3.89352,-2.86055 -42.35201,-34.326578 -100.03973,-34.326578 -57.687723,0 -96.146206,31.466028 -99.96027,34.326578 l 99.88081,124.433846 0.0795,0.15892 0.0795,-0.0795 55.54231,-69.20938 V 87.216094 Z" />
    <path
       style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:7.9459672"
       inkscape:connector-curvature="0"
       id="path6"
       d="m 75.196095,142.4406 44.974175,55.93961 v 0.0795 -0.0795 l 44.97418,-56.01907 c -1.74812,-1.27135 -18.99087,-15.41518 -44.97418,-15.41518 -25.983313,0 -43.226063,14.14383 -44.974175,15.49464 z m 116.487885,56.01907 h 15.89193 v -15.89193 h -15.89193 z m 0,-95.35161 v 63.56774 h 15.89193 v -63.56774 z" />
  </g>
</svg>
''
