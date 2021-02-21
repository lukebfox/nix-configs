{ config, pkgs, lib }:
let 
  inherit (pkgs) writeText;
  inherit (config.lib.base16) theme;
  
in writeText "logo-background" ''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>

<svg
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:cc="http://creativecommons.org/ns#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    width="1920"
    height="1080"
    viewBox="0 0 1800 1012.5"
    id="svg1" >
  <g
      id="layer2"
      transform="translate(-23.75651,552.51002)" >
    <rect
        id="bg"
        x="23.75651"
        y="-552.51001"
        width="1800"
        height="1012.5"
        style="fill:#${theme.base00-hex};" />
  </g>
  <g
      id="layer1"
      transform="translate(-156.33871,1510.5502)">
    <path
        id="dendriteA"
        style="fill:#${theme.base08-hex};"
        d="m 1002.713,-1086.123 -122.21755,211.66311 -28.53477,-48.37 32.93839,-56.6875 -65.41521,-0.1719 -13.9414,-24.16981 14.23637,-24.721 93.11177,0.2939 33.46371,-57.6903 z" />
    <path
        id="dendriteB"
        style="fill:#${theme.base0A-hex};"
        d="m 1012.0891,-916.92269 244.4144,0.012 -27.6223,48.8968 -65.562,-0.1817 32.5588,56.7371 -13.961,24.1585 -28.5272,0.032 -46.3013,-80.7841 -66.6932,-0.1353 z" />
    <path
        id="dendriteC"
        style="fill:#${theme.base0D-hex};"
        d="m 1154.3469,-1009.6683 -122.1968,-211.6751 56.1571,-0.5268 32.6236,56.8692 32.8564,-56.5653 27.9024,0.011 14.2909,24.6896 -46.8105,80.4902 33.2294,57.8256 z" />
    <path
        id="dendriteD"
        style="fill:#${theme.base09-hex};"
        d="m 958.6074,-998.93179 122.1968,211.6751 -56.157,0.5268 -32.62363,-56.8692 -32.85645,56.5653 -27.90237,-0.011 -14.29086,-24.6896 46.81047,-80.4902 -33.22946,-57.8256 z" />
    <path
        id="dendriteE"
        style="fill:#${theme.base0E-hex};"
        d="m 1100.5402,-1092.2123 -244.41445,-0.012 27.62229,-48.8969 65.56199,0.1817 -32.55875,-56.7371 13.96097,-24.1585 28.52722,-0.031 46.30133,80.7841 66.6931,0.1352 z" />
    <path
       id="dendriteF"
       style="fill:#${theme.base0B-hex};"
       d="m 1110.0755,-922.52219 122.2176,-211.66311 28.5348,48.3701 -32.9384,56.6875 65.4152,0.1718 13.9414,24.1698 -14.2364,24.72111 -93.1117,-0.294 -33.4637,57.6904 z"/>
  </g>
</svg>

''
