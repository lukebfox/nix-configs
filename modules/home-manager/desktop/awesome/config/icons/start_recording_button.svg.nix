{ nixosConfig, config, pkgs, ... }:
let
  inherit (config.lib.base16) theme;
  inherit (pkgs) writeText;

in writeText "awesome-icons-start_recording_button" ''
<?xml version="1.0"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 426.667 426.667" style="enable-background:new 0 0 426.667 426.667;" xml:space="preserve" width="512px" height="512px" class=""><g><g>
	<g>
		<path d="M213.333,0C95.513,0,0,95.513,0,213.333s95.513,213.333,213.333,213.333s213.333-95.513,213.333-213.333    S331.154,0,213.333,0z M213.333,387.413c-96.142,0-174.08-77.938-174.08-174.08s77.938-174.08,174.08-174.08    c96.093,0.118,173.962,77.987,174.08,174.08C387.413,309.475,309.475,387.413,213.333,387.413z" data-original="#000000" class="active-path" data-old_color="#000000" fill="#${theme.base07-hex}"/>
	</g>
</g><g>
	<g>
		<circle cx="213.333" cy="213.333" r="64" data-original="#000000" class="active-path" data-old_color="#000000" fill="#${theme.base07-hex}"/>
	</g>
</g><g>
	<g>
		<path 			d="M213.333,128C166.205,128,128,166.205,128,213.333s38.205,85.333,85.333,85.333s85.333-38.205,85.333-85.333    S260.462,128,213.333,128z M213.333,256c-23.564,0-42.667-19.103-42.667-42.667s19.103-42.667,42.667-42.667    S256,189.769,256,213.333S236.897,256,213.333,256z" data-original="#000000" class="active-path" data-old_color="#000000" fill="#${theme.base07-hex}"/>
	</g>
</g></g> </svg>
''
