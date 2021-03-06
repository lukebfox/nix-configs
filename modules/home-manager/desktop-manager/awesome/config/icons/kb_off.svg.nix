{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-kb_off" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="24"
   height="24"
   viewBox="0 0 24 24"
   version="1.1"
   id="svg6"
   sodipodi:docname="kb-off.svg"
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
     inkscape:window-height="742"
     id="namedview8"
     showgrid="false"
     inkscape:zoom="9.8333333"
     inkscape:cx="-6.9661017"
     inkscape:cy="12"
     inkscape:window-x="45"
     inkscape:window-y="26"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg6" />
  <path
     d="M20 5H4c-1.1 0-1.99.9-1.99 2L2 17c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm-9 3h2v2h-2V8zm0 3h2v2h-2v-2zM8 8h2v2H8V8zm0 3h2v2H8v-2zm-1 2H5v-2h2v2zm0-3H5V8h2v2zm9 7H8v-2h8v2zm0-4h-2v-2h2v2zm0-3h-2V8h2v2zm3 3h-2v-2h2v2zm0-3h-2V8h2v2z"
     id="path2"
     style="fill:#${theme.base07-hex};fill-opacity:0.33333334" />
  <path
     d="M0 0h24v24H0zm0 0h24v24H0z"
     fill="none"
     id="path4" />
</svg>
''
