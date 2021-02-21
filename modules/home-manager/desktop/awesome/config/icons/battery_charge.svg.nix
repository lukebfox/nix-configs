{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-battery_charge" ''
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
   id="Capa_1"
   x="0px"
   y="0px"
   viewBox="0 0 240 240"
   xml:space="preserve"
   width="240"
   height="240"
   sodipodi:docname="battery-charge.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14"><metadata
   id="metadata15"><rdf:RDF><cc:Work
       rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
         rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><defs
   id="defs13" /><sodipodi:namedview
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
   id="namedview11"
   showgrid="false"
   inkscape:pagecheckerboard="true"
   inkscape:zoom="0.4609375"
   inkscape:cx="-157.28814"
   inkscape:cy="256"
   inkscape:window-x="45"
   inkscape:window-y="28"
   inkscape:window-maximized="0"
   inkscape:current-layer="Capa_1" /><g
   id="g8"
   transform="matrix(0.390625,0,0,0.390625,20,20)"><g
     id="g6">
	<g
   id="g4">
		<path
   d="M 384,64 H 341.333 V 10.68 C 341.333,4.777 337.27,0 331.375,0 H 181.333 c -5.896,0 -10.667,4.777 -10.667,10.68 V 64 H 128 C 104.469,64 85.333,82.62 85.333,106.18 V 469.283 C 85.333,492.842 104.469,512 128,512 h 256 c 23.531,0 42.667,-19.158 42.667,-42.718 V 106.18 C 426.667,82.62 407.531,64 384,64 Z m -44.25,208.26 -85.333,138.667 c -1.979,3.208 -5.448,5.073 -9.083,5.073 -0.969,0 -1.938,-0.135 -2.906,-0.406 -4.594,-1.292 -7.76,-5.49 -7.76,-10.26 V 320 h -53.333 c -3.865,0 -7.427,-2.094 -9.313,-5.458 -1.885,-3.375 -1.802,-7.51 0.229,-10.802 l 85.333,-138.667 c 2.5,-4.063 7.406,-5.927 11.99,-4.667 4.594,1.292 7.76,5.49 7.76,10.26 V 256 h 53.333 c 3.865,0 7.427,2.094 9.313,5.458 1.885,3.375 1.801,7.511 -0.23,10.802 z"
   data-original="#000000"
   class="active-path"
   data-old_color="#000000"
   id="path2"
   inkscape:connector-curvature="0"
   style="fill:#${theme.base07-hex}" />
	</g>
</g></g> </svg>
''
