{
  description = "Personal Nix infrastructure, managed with bleeding edge NixOps";

  inputs = {
    nixpkgs.url          = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/master";
    home-manager.url     = "github:nix-community/home-manager";
    emacs.url            = "github:nix-community/emacs-overlay";
    nixops-plugged.url   = "github:lukebfox/nixops-plugged";
    base16.url           = "github:lukebfox/base16-nix";
    flake-utils.url      = "github:numtide/flake-utils";
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-unstable
            , base16
            , emacs
            , flake-utils
            , home-manager
            , nixops-plugged
            , ... } @ inputs:
    let
      # Bring some lib functions into scope.
      inherit (builtins) attrValues;
      inherit (nixpkgs.lib) importTOML nixosSystem optionalString;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem;

      # Import my lib and bring some functions into scope.
      utilities = import ./utilities { inherit (nixpkgs) lib; };
      inherit (utilities)
        importOverlays
        importSecrets
        pathsToImportedAttrs
        recImport;

      # Define a function which imports some package set, applying my overlays.
      pkgImport = nixpkgs: system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = (attrValues self.overlays) ++ [
          emacs.overlay
        ];
      };

      # Import shared and secret data.
      shared  = importTOML ./data/shared.toml;
      secrets = importSecrets ./data/secret;
    in {

      ##########################################################################
      ## NixOps Network Configurations

      # Attrset of deployable NixOps network configurations.
      nixopsConfigurations =
        let
          # Import unstable and master package sets for NixOS.
          pkgs         = pkgImport nixpkgs "x86_64-linux";
          unstablePkgs = pkgImport nixpkgs-unstable "x86_64-linux";
        in {
          /* NOTE (06/02/21)
             NixOps master only supports deploying from the fixed flake output
             fragment of `nixopsConfigurations.default`. This behaviour is hard-
             -coded in `eval-machines-info.nix`. Later, I hope a single flake
             will be able to support deploying multiple networks by selecting
             the respective flake output fragment e.g.

             # $ nixops create -d my-network --flake "path/to/flake#my-net"
          */
          default = {
            inherit nixpkgs; # REVIEW
            # Configuration shared between all machines.
            defaults =
              { ... }:
              {
                # Augment standard NixOS module arguments.
                _module.args = {
                  inherit unstablePkgs base16 shared secrets utilities;
                };
                # Make available various NixOS modules.
                imports = import ./modules/nixos/list.nix ++ [
                  (home-manager.nixosModules.home-manager)
                  # Inline module to set defaults.
                  {
                    imports = [
                      ./profiles/nixos/common.nix
                    ];
                    nix.nixPath = [
                      "nixpkgs=${nixpkgs}"
                      "nixpkgs-unstable=${nixpkgs-unstable}"
                    ];
                    # NOTE This seems to work in lieu of a specialArgs option.
                    nixpkgs.pkgs = pkgs;
                  }
                ];
              };
          # Import the network configuration's nix expression.
          } // import ./configs/nixops/default.nix (inputs // {
            inherit pkgs unstablePkgs secrets shared utilities;
          });
        };


      ##########################################################################
      ## NixOS Modules & NixOS Host Configurations

      # Attrset of custom NixOS modules.
      nixosModules =
        let
          moduleList  = import ./modules/nixos/list.nix;
          profileList = import ./profiles/nixos/list.nix;
        in pathsToImportedAttrs moduleList // {
          profiles = pathsToImportedAttrs profileList;
        };

      # Attrset NixOS configurations buildable via nixos-rebuild.
      nixosConfigurations =
        let
          system       = "x86_64-linux";
          pkgs         = pkgImport nixpkgs system;
          unstablePkgs = pkgImport nixpkgs system;
          # Import function which takes a hostname and returns a config artifact
          importConfiguration = hostName: nixosSystem {
            inherit system;
            /* Things in these sets are passed to NixOS modules and made
               accessible in the top-level arguments i.e.
               `{ config, pkgs, lib, usr, base16, unstablePkgs, ... }:`
               specialArgs get evaluated when resolving module structure.
               `_module.args` is built from specialArgs and extraArgs.
             */
            specialArgs = { inherit pkgs shared secrets; };
            extraArgs   = { inherit base16 unstablePkgs utilities; };
            # Make available various NixOS modules,
            modules = (import ./modules/nixos/list.nix) ++ [
              (home-manager.nixosModules.home-manager)
              # Inline module to set defaults and import the host's config.
              {
                imports = [
                  (./configs/nixos + "/${hostName}.nix")
                  ./profiles/nixos/common.nix
                ];
                nix.nixPath = [
                  "nixpkgs=${nixpkgs}"
                  "nixpkgs-unstable=${nixpkgs-unstable}"
                ];
                networking.hostName = hostName;
              }
            ];
          };
        in recImport { _import = importConfiguration;  dir = ./configs/nixos; };


      ##########################################################################
      ## Home Manager Modules & Home Manager Home Configurations

      # Attrset of custom Home Manager modules.
      homeManagerModules =
        let
          moduleList  = import ./modules/home-manager/list.nix;
          profileList = import ./profiles/home-manager/list.nix;
        in pathsToImportedAttrs moduleList // {
          profiles = pathsToImportedAttrs profileList;
        };

      # Attrset of home-manager configurations installable with:
      # `nix build .#LA-373.activationPackage; ./result/activate`
      homeManagerConfigurations =
        let
          system       = "x86_64-darwin";
          pkgs         = pkgImport nixpkgs system;
          unstablePkgs = pkgImport nixpkgs-unstable system;
        in
        {
          LA-373 = homeManagerConfiguration {
            inherit system pkgs;
            username = "luke.bentley.fox";
            homeDirectory = "/User/luke.bentley.fox";
            extraSpecialArgs = {
              inherit unstablePkgs utilities shared secrets;
            };
            configuration = {
              imports = (import ./modules/home-manager/list.nix) ++ [
                (base16.homeManagerModules.base16)
                ./profiles/home-manager/common.nix
              ];
            };
          };
        };


      ##########################################################################
      ## Nixpkgs Overlays

      # An overlay for including my custom packages in some package set.
      overlay = import ./packages;

      # Attrset of overlays which override various standard packages.
      overlays = importOverlays ./overlays;


    # Now follows a bunch of outputs multiplexed for common systems.
    } // eachDefaultSystem (system:
      let
        pkgs = pkgImport nixpkgs system;
      in {

        ########################################################################
        ## Nixpkgs Packages

        # Attrset of custom nix packages.
        packages = self.overlay pkgs pkgs;


        ########################################################################
        ## Development/Deployment Environment

        # A nix shell containing a nixops capable of deploying my network.
        devShell = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.git
            pkgs.git-crypt
            pkgs.nixFlakes
            nixops-plugged.packages.${system}.nixops-hetznercloud
          ];
          shellHook = ''
            mkdir -p data/secret

            # use gpg-agent to handle SSH in this shell
            export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
            gpgconf --launch gpg-agent
          '';
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
