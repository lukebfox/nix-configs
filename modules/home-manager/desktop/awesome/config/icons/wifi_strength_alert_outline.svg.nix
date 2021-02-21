{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_alert_outline" ''
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
   width="48"
   height="48"
   viewBox="0 0 4.8 4.8"
   enable-background="new 0 0 24.00 24.00"
   xml:space="preserve"
   id="svg4"
   sodipodi:docname="wifi_strength_alert_outline.svg"
   inkscape:version="0.92.5 (2060ec1f9f, 2020-04-08)"><metadata
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
   inkscape:cx="-99.661017"
   inkscape:cy="120"
   inkscape:window-x="45"
   inkscape:window-y="28"
   inkscape:window-maximized="0"
   inkscape:current-layer="svg4" />
<path
   d="M 2.3996249,0.50003992 C 1.5568511,0.50197892 0.7398204,0.78315394 0.0749994,1.300765 H 0.072 C 0.8482913,2.2662659 1.624333,3.2317468 2.4013844,4.1972277 2.8672594,3.6173833 3.3328744,3.0365592 3.7985095,2.4566948 V 1.8171264 L 2.3996249,3.5599187 0.65384344,1.3874917 C 1.1802022,1.0703269 1.7835402,0.90137221 2.3996249,0.90037248 3.0137001,0.90337148 3.6160584,1.0720764 4.1411575,1.3904909 L 4.0533615,1.4997116 H 4.5660439 C 4.6195299,1.4334794 4.6732551,1.3669972 4.7270007,1.300765 H 4.728 C 4.0621787,0.78215421 3.2431385,0.50097967 2.3996249,0.50003992 Z M 4.198902,1.9001042 V 3.499175 H 4.5980349 V 1.9001042 M 4.198902,3.8995676 V 4.2999601 H 4.5980349 V 3.8995676"
   id="path2"
   inkscape:connector-curvature="0"
   style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:0.03998927;stroke-linejoin:round" />
</svg>
''
