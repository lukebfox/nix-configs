{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-wifi" ''
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="240" height="240" viewBox="0 0 24.00 24.00" enable-background="new 0 0 24.00 24.00" xml:space="preserve">
   <path fill="#${theme.base07-hex}" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 12,21L 15.6002,16.1997C 14.5974,15.4464 13.3508,15 12,15C 10.6492,15 9.40262,15.4464 8.39979,16.1997L 12,21 Z M 12,3C 7.94753,3 4.20785,4.33919 1.19937,6.59916L 2.99947,8.9993C 5.50654,7.116 8.62294,6.00001 12,6.00001C 15.377,6.00001 18.4934,7.116 21.0005,8.99931L 22.8006,6.59916C 19.7921,4.33919 16.0525,3 12,3 Z M 12,9C 9.29836,9 6.80524,9.8928 4.79958,11.3994L 6.59968,13.7996C 8.10393,12.6696 9.97376,12 12,12C 14.0262,12 15.8961,12.6696 17.4003,13.7996L 19.2004,11.3994C 17.1948,9.8928 14.7016,9 12,9 Z "/>
</svg>
''
