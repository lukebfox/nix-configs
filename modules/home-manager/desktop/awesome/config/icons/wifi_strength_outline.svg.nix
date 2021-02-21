{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_outline" ''
<?xml version="1.0" encoding="utf-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="240" height="240" viewBox="0 0 24.00 24.00" enable-background="new 0 0 24.00 24.00" xml:space="preserve">
   <path fill="#${theme.base07-hex}" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 12.0025,2.9978C 7.7875,3.0075 3.70125,4.41375 0.376253,7.0025L 0.361252,7.0025C 4.24375,11.8313 8.125,16.66 12.0113,21.4887C 15.8888,16.66 19.7662,11.8313 23.6425,7.0025L 23.6475,7.0025C 20.3175,4.40875 16.2212,3.0025 12.0025,2.9978 Z M 12.0025,5C 15.0737,5.015 18.0863,5.85875 20.7125,7.45125L 12.0025,18.3013L 3.27125,7.43625C 5.90375,5.85 8.92125,5.005 12.0025,5 Z "/>
</svg>
''
