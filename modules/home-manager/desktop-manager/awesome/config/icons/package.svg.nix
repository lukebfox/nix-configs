{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-package" ''
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
   viewBox="0 0 24.00 24.00"
   enable-background="new 0 0 24.00 24.00"
   xml:space="preserve"
   id="svg4"
   sodipodi:docname="package.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14"><metadata
   id="metadata10"><rdf:RDF><cc:Work
       rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
         rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><defs
   id="defs8" /><sodipodi:namedview
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
   inkscape:cx="120"
   inkscape:cy="120"
   inkscape:window-x="45"
   inkscape:window-y="28"
   inkscape:window-maximized="0"
   inkscape:current-layer="svg4" />
	<path
   d="M 4.3555556,4.2222123 H 19.633333 L 18.588889,3.1111006 H 5.2555556 Z M 21.488889,4.4777792 C 21.811222,4.8555571 22,5.3555574 22,5.888891 V 19.777777 C 22,20.999999 21,22 19.777778,22 H 4.2222222 C 3,22 2,20.999999 2,19.777777 V 5.888891 C 2,5.3555574 2.1888889,4.8555571 2.5111111,4.4777792 L 4.0444444,2.6111115 C 4.3555556,2.2333335 4.8111,2 5.3333333,2 H 18.666667 c 0.522222,0 0.977777,0.2333335 1.277777,0.6111115 z M 5.3333333,18.666665 H 12 V 15.33333 H 5.3333333 Z"
   id="path2"
   inkscape:connector-curvature="0"
   style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:0.22222228;stroke-linejoin:round" />
</svg>
''
