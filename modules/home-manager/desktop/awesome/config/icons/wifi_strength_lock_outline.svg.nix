{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi_strength_lock_outline" ''
<?xml version="1.0" encoding="utf-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="240" height="240" viewBox="0 0 24.00 24.00" enable-background="new 0 0 24.00 24.00" xml:space="preserve">
   <path fill="#$theme.base07-hex}" fill-opacity="1" stroke-width="1.33333" stroke-linejoin="miter" d="M 12,3C 7.78946,3.0086 3.70106,4.4156 0.376954,7C 4.60705,12.3026 8.15995,16.7043 12.0098,21.4902C 13.2095,19.9999 14.2927,18.6499 15.5,17.1445L 15.5,14.5C 15.5019,14.2962 15.5162,14.0927 15.543,13.8906L 12.0039,18.2988L 3.26953,7.4355C 5.90565,5.8486 8.92306,5.0068 12,5C 15.0729,5.0137 18.0847,5.8602 20.7148,7.4492L 18.834,9.791C 19.3688,9.6001 19.9322,9.5017 20.5,9.5C 20.8521,9.5021 21.203,9.5414 21.5469,9.6172C 22.2135,8.7884 23.0231,7.7739 23.6484,7C 20.3175,4.4103 16.2192,3.003 12,3 Z M 20.5,12C 19.1,12 18,13.1 18,14.5L 18,16C 17.5,16 17,16.5 17,17L 17,21C 17,21.5 17.5,22 18,22L 23,22C 23.5,22 24,21.5 24,21L 24,17C 24,16.5 23.5,16 23,16L 23,14.5C 23,13.1 21.9,12 20.5,12 Z M 20.5,13C 21.3,13 22,13.7 22,14.5L 22,16L 19,16L 19,14.5C 19,13.7 19.7,13 20.5,13 Z "/>
</svg>
''
