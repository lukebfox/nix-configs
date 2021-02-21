{ config, pkgs, ... }:
let 
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;
  
in writeText "logo-background-filled" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="1920"
   height="1080"
   viewBox="0 0 1800 1012.5"
   id="svg1"
   version="1.1"
   sodipodi:docname="logo-background-filled.svg"
   inkscape:version="1.0.1 (3bc2e813f5, 2020-09-07)">
  <defs
     id="defs447" />
  <g
     id="background"
     transform="translate(-23.75651,552.51002)"
     style="display:inline">
    <rect
       style="fill:#${theme.base00-hex};"
       id="left"
       width="1800"
       height="1012.5"
       x="23.75651"
       y="-552.51002"
       ry="0" />
    <path
       style="fill:#${theme.base06-hex};"
       d="m 918.16415,-551.66234 905.59235,-0.84767 v 1012.5 l -281.4322,1.27393 -353.1643,-423.154086 32.3175,-89.051751 93.8203,-16.426617 -96.5965,-115.113426 z"
       id="dark" />
    <path
       style="fill:#${theme.base06-hex};"
       id="center"
       d="m 1347.1704,98.36116 -110.8136,18.42242 -71.777,-84.316421 39.0362,-102.738847 110.8134,-18.422423 71.7772,84.3164236 z" />
  </g>
  <g
     id="logo"
     transform="rotate(-70,2290.3489,-360.23035)">
    <path
       id="dendrite8"
       style="fill:#${theme.base08-hex};"
       d="m 1012.2556,-1092.4838 -122.21742,211.66353 -28.53477,-48.37 32.93839,-56.6875 -65.41521,-0.1719 -13.9414,-24.17023 14.23637,-24.721 93.11177,0.2939 33.46371,-57.6903 z" />
    <path
       id="dendriteE"
       style="fill:#${theme.base0E-hex};"
       d="m 1106.8225,-1092.2123 -244.41517,-0.012 27.62229,-48.8969 65.56199,0.1817 -32.55875,-56.7371 13.96097,-24.1585 28.52722,-0.031 46.30135,80.7841 66.694,0.1352 z" />
    <path
       id="dendriteD"
       style="fill:#${theme.base0D-hex};"
       d="m 1154.3469,-1009.6683 -122.1968,-211.6751 56.1571,-0.5268 32.6236,56.8692 32.8564,-56.5653 27.9024,0.011 14.2909,24.6896 -46.8105,80.4902 33.2294,57.8256 z" />
    <path
       id="dendriteB"
       style="fill:#${theme.base0B-hex};"
       d="m 1106.9983,-928.05098 122.2176,-211.66302 28.5348,48.3701 -32.9384,56.6875 65.4152,0.1718 13.9414,24.1698 -14.2364,24.72102 -93.1117,-0.294 -33.4637,57.6904 z" />
    <path
       id="dendriteA"
       style="fill:#${theme.base0A-hex};"
       d="m 1011.8083,-928.17269 244.4151,0.012 -27.6223,48.8968 -65.562,-0.1817 32.5588,56.7371 -13.961,24.1585 -28.5272,0.032 -46.3013,-80.7841 -66.6932,-0.1353 z" />
    <path
       id="dendrite9"
       style="fill:#${theme.base09-hex};"
       d="m 964.60722,-1010.1818 122.19708,211.67511 -56.157,0.5268 -32.62391,-56.8692 -32.85645,56.5653 -27.90237,-0.011 -14.29086,-24.6896 46.81047,-80.4902 -33.22946,-57.8256 z" />
  </g>
</svg>
''
