{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-settings" ''
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
   sodipodi:docname="ic_settings_48px.svg"
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
     inkscape:zoom="2.4583333"
     inkscape:cx="113.59335"
     inkscape:cy="135.94651"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg4" />
  <path
     d="m 194.275,129.75 c 0.4,-3.2 0.7,-6.45 0.7,-9.75 0,-3.3 -0.3,-6.55 -0.7,-9.75 l 21.15,-16.55 c 1.9,-1.5 2.45,-4.2 1.2,-6.4 l -20,-34.65 c -1.25,-2.15 -3.85,-3.05 -6.1,-2.15 l -24.9,10.05 c -5.15,-3.95 -10.8,-7.3 -16.9,-9.85 l -3.75,-26.5 c -0.45,-2.35 -2.5,-4.2 -5,-4.2 h -40 c -2.5,0 -4.55,1.85 -4.95,4.2 l -3.75,26.5 c -6.1,2.55 -11.75,5.85 -16.9,9.85 L 49.475,50.5 c -2.25,-0.85 -4.85,0 -6.1,2.15 l -20,34.65 c -1.25,2.15 -0.7,4.85 1.2,6.4 l 21.1,16.55 c -0.4,3.2 -0.7,6.45 -0.7,9.75 0,3.3 0.3,6.55 0.7,9.75 l -21.1,16.55 c -1.9,1.5 -2.45,4.2 -1.2,6.4 l 20,34.65 c 1.25,2.15 3.85,3.05 6.1,2.15 l 24.9,-10.05 c 5.15,3.95 10.8,7.3 16.9,9.85 l 3.75,26.5 c 0.4,2.35 2.45,4.2 4.95,4.2 h 40 c 2.5,0 4.55,-1.85 4.95,-4.2 l 3.75,-26.5 c 6.1,-2.55 11.75,-5.85 16.9,-9.85 l 24.9,10.05 c 2.25,0.85 4.85,0 6.1,-2.15 l 20,-34.65 c 1.25,-2.15 0.7,-4.85 -1.2,-6.4 z m -74.3,25.25 c -19.35,0 -35,-15.65 -35,-35 0,-19.35 15.65,-35 35,-35 19.35,0 35,15.65 35,35 0,19.35 -15.65,35 -35,35 z"
     id="path2"
     inkscape:connector-curvature="0"
     style="stroke-width:5;fill:#${theme.base07-hex};fill-opacity:1" />
</svg>
''
