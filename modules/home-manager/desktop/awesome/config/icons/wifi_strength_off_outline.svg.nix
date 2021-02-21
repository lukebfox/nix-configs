{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_off_outline" ''
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
   sodipodi:docname="wifi-strength-off-outline.svg"
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
   inkscape:zoom="5.5625733"
   inkscape:cx="-15.604564"
   inkscape:cy="55.265344"
   inkscape:window-x="45"
   inkscape:window-y="28"
   inkscape:window-maximized="0"
   inkscape:current-layer="svg4" />
  <path
   d="M 0.65121718,0.3943759 0.39737174,0.6503682 0.8075259,1.0606264 C 0.54767825,1.1809217 0.30058535,1.3294775 0.072,1.5072944 0.8377873,2.466415 1.6243331,3.4415216 2.3998847,4.4056241 L 3.1796578,3.4337787 3.8439276,4.0980284 4.097763,3.8439329 C 2.9715996,2.7157487 0.65121718,0.3943759 0.65121718,0.3943759 Z M 2.398124,0.7060531 c -0.2813658,9.404e-4 -0.5589602,0.035203 -0.8285615,0.096726 l 0.3398778,0.3408781 c 0.1613006,-0.023259 0.3243619,-0.037014 0.4886837,-0.037014 0.614471,0.003 1.2172177,0.1718147 1.7426552,0.4904345 L 3.3494817,2.5836991 3.6338286,2.868066 C 4.0139715,2.3933675 4.4016373,1.9116964 4.728,1.5072944 4.0617495,0.9883492 3.2421814,0.7069935 2.398124,0.7060531 Z M 1.1103898,1.3644907 2.8953109,3.1484114 2.398124,3.7679043 0.65121718,1.594077 C 0.7987727,1.5052936 0.9520803,1.4290149 1.1103898,1.3644907 Z"
   id="path2"
   inkscape:connector-curvature="0"
   style="fill:#${theme.base07-hex};fill-opacity:1;stroke-width:0.04001505;stroke-linejoin:round" />
</svg>
''
