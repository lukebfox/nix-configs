{
  description = "Personal Nix infrastructure, managed with NixOps 2.0";

  inputs = {
    nixpkgs =          { url = "nixpkgs/nixos-unstable"; };
    nixpkgs-unstable = { url = "nixpkgs/master"; };
    home-manager =     { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-wsl =        { url = "github:nix-community/NixOS-WSL"; inputs.nixpkgs.follows = "nixpkgs"; };
    rust-overlay =     { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixpkgs"; };
    emacs-overlay =    { url = "github:nix-community/emacs-overlay"; };
    base16 =           { url = "github:lukebfox/base16-nix"; };
    deadnix =          { url = "github:astro/deadnix"; inputs.nixpkgs.follows = "nixpkgs"; };
    flake-utils =      { url = "github:numtide/flake-utils"; };
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-unstable
            , home-manager
            , nixos-wsl
            , emacs-overlay
            , rust-overlay
            , base16
            , deadnix
            , flake-utils
            , ... } @ inputs:
    let
      # Bring some lib functions into scope.
      inherit (builtins) attrValues;
      inherit (nixpkgs.lib) importTOML nixosSystem optionalString;
      #inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem;

      # Import my lib and bring some functions into scope.
      utilities = import ./utilities { inherit (nixpkgs) lib; };
      inherit (utilities)
        exportableModules
        importOverlays
        recImport;

      # Import shared data.
      shared  = importTOML ./data/shared.toml; # REVIEW justify toml over nix

      # Define a function which imports some package set, applying my overlays.
      pkgImport = nixpkgs: system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = (attrValues self.overlays) ++ [
          emacs-overlay.overlays.default
          rust-overlay.overlays.default
        ];
      };

    in {

      # Why output this? Because you'll need to reference this to use any modules
      # which rely on my lib functions.
      lib = utilities;

      ##########################################################################
      ## NixOps Network Configurations

      # Attrset of deployable NixOps network configurations.
      nixopsConfigurations =
        let
          # Import package sets for NixOS.
          pkgs         = pkgImport nixpkgs "x86_64-linux";
          unstablePkgs = pkgImport nixpkgs-unstable "x86_64-linux";
        in {
          /* NOTE (06/02/21)
             NixOps master only supports deploying from the fixed flake output
             fragment of `nixopsConfigurations.default`. This behaviour is hard-
             -coded in `eval-machines-info.nix`. Later, I hope a single flake
             will be able to support deploying multiple networks by selecting
             the respective flake output fragment e.g.

             # $ nixops create -d my-net --flake "path/to/flake#my-net"
          */
          default = {
            # REVIEW understand why this works
            inherit nixpkgs;
            # Configuration shared between all machines.
            defaults =
              { ... }:
              {
                # Augment standard NixOS module arguments.
                _module.args = {
                  inherit unstablePkgs base16 shared utilities;
                };
                # Make available various NixOS modules.
                imports = import ./modules/nixos/list.nix ++ [
                  (home-manager.nixosModules.home-manager)
                  # Inline module to set defaults.
                  {
                    imports = [ ./profiles/nixos/common.nix ];
                    nix.nixPath = [
                      "nixpkgs=${nixpkgs}"
                      "nixpkgs-unstable=${nixpkgs-unstable}"
                    ];
                    # NOTE Using this is satisfactory in lieu of a specialArgs option.
                    nixpkgs.pkgs = pkgs;
                  }
                ];
              };
          # Import the network configuration's nix expression.
          } // import ./configs/nixops/default.nix (inputs // {
            inherit pkgs unstablePkgs shared utilities;
          });
        };

      ##########################################################################
      ## NixOS Modules & NixOS Host Configurations

      # Attrset of custom NixOS modules.
      nixosModules = exportableModules "nixos";

      # Attrset NixOS configurations installable locally with:
      # `nixos-rebuild --flake .#<name?> switch`
      # or with nixFlakes:
      # `nixos-rebuild switch`
      nixosConfigurations =
        let
          system       = "x86_64-linux";
          pkgs         = pkgImport nixpkgs system;
          unstablePkgs = pkgImport nixpkgs system;
          mkNixosConfiguration = hostName: nixosSystem {
            inherit system;
            /* This should only be used for special arguments that need to be
               evaluated when resolving module structure (like in imports).
               specialArgs also gets included in _module.args
             */
            specialArgs = { inherit pkgs shared; };
            # Make available various NixOS modules,
            modules = import ./modules/nixos/list.nix ++ [
              (home-manager.nixosModules.home-manager)
              (nixos-wsl.nixosModules.wsl)
              # Inline module to set defaults and import the host's config.
              {
                # Augment standard NixOS module arguments.
                _module.args = { inherit base16 unstablePkgs utilities; };
                imports = [
                  ./profiles/nixos/common.nix
                  (./configs/nixos + "/${hostName}.nix")
                ];
                nix.nixPath = [
                  "nixpkgs=${nixpkgs}"
                  "nixpkgs-unstable=${nixpkgs-unstable}"
                ];
                networking.hostName = hostName;
              }
            ];
          };
        in recImport { _import = mkNixosConfiguration; dir = ./configs/nixos; };


      ##########################################################################
      ## Home Manager Modules & Home Manager Home Configurations

      # Attrset of custom Home Manager modules.
      homeManagerModules = exportableModules "home-manager";

      /*
      NOTE: Commented because I no longer have non-nixos machines to manage.

      # Attrset of home-manager configurations installable locally with:
      # `nix build .#<name?>.activationPackage && ./result/activate`
      homeManagerConfigurations =
        let
          mkHomeManagerConfiguration =
            { system, configuration, username, homeDirectory }:
            let
              pkgs         = pkgImport nixpkgs system;
              unstablePkgs = pkgImport nixpkgs-unstable system;
            in
            homeManagerConfiguration {
              inherit system pkgs username homeDirectory;
              check = false;
              extraSpecialArgs = {
                inherit system pkgs unstablePkgs utilities shared;
              };
              configuration = {
                imports = import ./modules/home-manager/list.nix ++ [
                  (base16.homeManagerModules.base16)
                  ./profiles/home-manager/common.nix
                  ./profiles/home-manager/standalone.nix
                  configuration
                ];
              };
            };
        in
        {
          ??? = mkHomeManagerConfiguration
            {
              system        = "x86_64-darwin";
              configuration = ./configs/home-manager/???.nix;
              username      = "???";
              homeDirectory = "/Users/???";
            };
        };
      */

      ##########################################################################
      ## Nixpkgs Overlays

      # Attrset of overlays which override various standard packages.
      overlays = (importOverlays ./overlays) // {
        # An overlay for including my custom packages in some package set.
        default = import ./packages;
      };
      # for backward compatibility, is safe to delete, not referenced anywhere
      overlay = self.overlays.default;

    # Now follows a bunch of outputs multiplexed for common systems.
    } // eachDefaultSystem (system:
      let
        pkgs         = pkgImport nixpkgs system;
        unstablePkgs = pkgImport nixpkgs-unstable system;
      in {

        ########################################################################
        ## Nixpkgs Packages

        # Attrset of custom nix packages.
        packages = self.overlay pkgs pkgs;

        ########################################################################
        ## Development/Deployment Environment

        # A nix shell containing a nixops capable of deploying my network.
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.gnupg
            pkgs.git
            pkgs.git-crypt
            pkgs.nixFlakes
            deadnix.packages.${system}.deadnix
            unstablePkgs.nixopsUnstable
          ];
          shellHook = ''
            mkdir -p data/secret

            # Force gpg-agent to handle SSH in this shell.
            # Required for yubikey gpg+ssh authentication pre-installation.
            export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
            gpgconf --launch gpg-agent
          '';
          # Version-control a git-crypted statefile so I can deploy from anywhere.
          NIXOPS_STATE = "./data/secret/localstate.nixops";
          NIX_CONF_DIR =
            let
              current =
                optionalString
                  (builtins.pathExists /etc/nix/nix.conf)
                  (builtins.readFile /etc/nix/nix.conf);
              nixConf = pkgs.writeTextDir "opt/nix.conf" ''
                ${current}
                experimental-features = nix-command flakes ca-references
              '';
            in "${nixConf}/opt";
        };
      }
    );
}
