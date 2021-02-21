{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-battery_charging_30" ''
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
   id="svg6"
   sodipodi:docname="ic_battery_charging_30_48px.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
  <metadata
     id="metadata12">
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
     id="defs10" />
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
     id="namedview8"
     showgrid="false"
     inkscape:pagecheckerboard="true"
     inkscape:zoom="4.9166667"
     inkscape:cx="-14.542373"
     inkscape:cy="24"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:current-layer="svg6" />
  <path
     fill-opacity=".3"
     d="M31.33 8H28V4h-8v4h-3.33C15.19 8 14 9.19 14 10.67V29h4l8-15v11h4l-2.13 4H34V10.67C34 9.19 32.81 8 31.33 8z"
     id="path2"
     style="fill:#${theme.base07-hex};fill-opacity:0.4" />
  <path
     d="M22 40V29h-8v12.33C14 42.8 15.19 44 16.67 44h14.67c1.47 0 2.67-1.19 2.67-2.67V29h-6.13L22 40z"
     id="path4"
     style="fill:#${theme.base07-hex};fill-opacity:1" />
</svg>
''
