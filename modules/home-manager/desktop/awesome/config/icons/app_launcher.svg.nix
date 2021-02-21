{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-app_launcher" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="240"
   height="240"
   viewBox="0 0 63.499999 63.500002"
   version="1.1"
   id="svg8"
   sodipodi:docname="menu.svg"
   inkscape:version="0.92.4 5da689c313, 2019-01-14">
  <defs
     id="defs2">
    <linearGradient
       inkscape:collect="always"
       id="linearGradient818">
      <stop
         style="stop-color:#4986ff;stop-opacity:1"
         offset="0"
         id="stop814" />
      <stop
         style="stop-color:#6ee6ff;stop-opacity:1"
         offset="1"
         id="stop816" />
    </linearGradient>
    <linearGradient
       inkscape:collect="always"
       xlink:href="#linearGradient818"
       id="linearGradient820"
       x1="8.385582"
       y1="296.68262"
       x2="8.385582"
       y2="280.71326"
       gradientUnits="userSpaceOnUse"
       gradientTransform="matrix(0.94925215,0,0,0.94925215,0.2894544,14.735886)" />
    <style
       type="text/css"
       id="current-color-scheme">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-3">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-7">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-35">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-9">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-2">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-0">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-36">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-6">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-61">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-79">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-23">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-92">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-97">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       type="text/css"
       id="current-color-scheme-612">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-1"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-3-0"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-7-6"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-35-3"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-9-2"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-2-0"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-0-6"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-36-1"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-6-5"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-61-5"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-79-4"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-23-7"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-92-6"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-97-5"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
    <style
       id="current-color-scheme-612-6"
       type="text/css">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; }
  </style>
  </defs>
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="1.4142136"
     inkscape:cx="74.898582"
     inkscape:cy="97.424315"
     inkscape:document-units="mm"
     inkscape:current-layer="layer1"
     showgrid="false"
     units="px"
     inkscape:window-width="1321"
     inkscape:window-height="740"
     inkscape:window-x="45"
     inkscape:window-y="28"
     inkscape:window-maximized="0"
     inkscape:pagecheckerboard="true" />
  <metadata
     id="metadata5">
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
  <g
     inkscape:label="Capa 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(0,-233.49998)">
    <g
       id="g874"
       transform="matrix(3.3983643,0,0,3.3983643,3.4458064,-715.60105)">
      <circle
         r="7.7856083"
         cy="288.62445"
         cx="8.3287697"
         id="path815"
         style="opacity:1;fill:url(#linearGradient820);fill-opacity:1;stroke:none;stroke-width:0.17561164;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" />
      <g
         id="text891"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:2.46166945px;line-height:1.25;font-family:Sawasdee;-inkscape-font-specification:Sawasdee;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.06154174"
         aria-label="hip-hip" />
      <path
         style="fill:#ffffff;fill-opacity:0.80632402;stroke-width:0.03253478"
         inkscape:connector-curvature="0"
         d="m 4.527458,285.00243 c -1.477e-4,0.003 6.645e-4,0.006 0.0013,0.01 0.2823217,2.66896 1.3924956,4.79539 2.9281302,5.44652 l 0.00814,0.56224 c 7.048e-4,0.0299 0.01022,0.0599 0.027444,0.0844 0.7221611,1.04094 1.5925032,1.69883 2.457392,2.17576 0.050738,0.0279 0.1169888,0.0241 0.1636898,-0.0102 0.04655,-0.0345 0.07154,-0.0977 0.06001,-0.15451 l -0.3334825,-1.64912 0.2907775,0.0813 c 0.04841,0.0136 0.103292,9.5e-4 0.141327,-0.0315 l 0.475832,-0.41582 c 2.95e-4,-3.3e-4 7.18e-4,-7.1e-4 10e-4,-9.5e-4 0.0056,-0.004 0.01045,-0.01 0.01539,-0.014 l 0.417888,-0.47682 c 0.03355,-0.0376 0.0459,-0.0927 0.03256,-0.1413 l -0.08133,-0.29078 1.649108,0.33348 c 0.0568,0.0115 0.119202,-0.0133 0.153539,-0.06 0.03447,-0.0465 0.03911,-0.11295 0.01118,-0.1637 -0.476896,-0.86481 -1.133763,-1.73418 -2.174742,-2.45637 -0.02453,-0.0173 -0.05444,-0.0277 -0.08441,-0.0285 l -0.5636,-0.009 c -0.6470467,-1.52866 -2.7395197,-2.65421 -5.3936577,-2.94237 -0.04696,-0.0165 -0.1023735,-0.008 -0.1423611,0.0223 -0.040189,0.0294 -0.063174,0.0795 -0.061031,0.12909 z m 1.878882,2.46146 c -4.631e-4,-0.0116 -3.82e-5,-0.0237 5.3e-6,-0.0356 -3e-7,-0.3808 0.3085336,-0.68933 0.6893309,-0.68933 0.3807978,0 0.689332,0.30853 0.6893323,0.68933 7e-7,0.3808 -0.3085332,0.68933 -0.689331,0.68933 -0.3689002,-10e-6 -0.6708652,-0.28944 -0.6893308,-0.65375 z"
         id="path4556-6" />
      <path
         style="fill:#ffffff;stroke-width:0.03253478"
         inkscape:connector-curvature="0"
         d="m 3.7758901,292.88342 c -0.2397884,0.23979 -0.3914968,0.53369 -0.4576975,0.8423 a 7.1733252,7.1733252 0 0 0 10.1094334,-0.0329 7.1733252,7.1733252 0 0 0 0.495363,-9.59346 c -0.262685,0.0286 -0.52062,0.1454 -0.725153,0.34994 -0.433631,0.43381 -0.477736,1.11427 -0.101774,1.57007 -0.27051,0.0304 -0.525498,0.15391 -0.721033,0.34917 -0.463808,0.46382 -0.477648,1.2019 -0.03092,1.64844 0.08846,0.0875 0.191099,0.15965 0.304,0.21327 -0.1963,0.0813 -0.375469,0.20104 -0.526668,0.352 -0.615207,0.61518 -0.633666,1.59414 -0.04124,2.18651 0.144654,0.1443 0.315294,0.25398 0.500253,0.3267 a 1.6963944,1.6963944 0 0 0 -0.510552,0.34861 1.6963944,1.6963944 0 0 0 -0.485633,1.38151 c -0.02922,-0.0177 -0.05844,-0.0357 -0.08865,-0.0519 0.04297,-0.3815 -0.08572,-0.75589 -0.351058,-1.0213 -0.336789,-0.33588 -0.841335,-0.44619 -1.3044894,-0.28526 -0.088565,-0.17357 -0.2033559,-0.33158 -0.3405465,-0.46874 -0.7571285,-0.75709 -2.0153254,-0.72637 -2.8102832,0.0686 -0.46303,0.46367 -0.6848893,1.11142 -0.5963905,1.74007 -0.6720046,-0.58851 -1.6852419,-0.55507 -2.3169701,0.0764 z"
         id="path4560-7" />
    </g>
  </g>
</svg>
''
