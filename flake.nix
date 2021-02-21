{
  description = "Personal Nix infrastructure, managed with bleeding edge NixOps";

  inputs = {
    nixpkgs.url          = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/master";
    home.url             = "github:nix-community/home-manager";
    emacs.url            = "github:nix-community/emacs-overlay";
    nixops-plugged.url   = "github:lukebfox/nixops-plugged";
    base16.url           = "github:lukebfox/base16-nix";
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-unstable
            , base16
            , emacs
            , home
            , nixops-plugged
            , ... } @ inputs:
    let
      # Everything in this flake is intended for GNU/Linux, for now.
      system = "x86_64-linux";

      # Import library functions, and bring some into scope.
      utilities = import ./utilities { inherit (nixpkgs) lib; };
      inherit (utilities)
        importOverlays
        importSecrets
        pathsToImportedAttrs
        recImport;

      # Define a function which imports some package set, applying my overlays.
      pkgImport = nixpkgs: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = (builtins.attrValues (importOverlays ./overlays)) ++ [
          emacs.overlay
        ];
      };

      # Import unstable and master package sets.
      pkgs         = pkgImport nixpkgs;
      unstablePkgs = pkgImport nixpkgs-unstable;

      # Import all data.
      shared  = nixpkgs.lib.importTOML ./data/shared.toml;
      secrets = importSecrets ./data/secret;

    in {

      ##########################################################################
      #                                NixPkgs                                 #
      ##########################################################################

      # Attrset of custom nix packages.
      packages.${system} = self.overlay pkgs pkgs;

      # An overlay for including the above packages in some package set.
      overlay = import ./packages;


      ##########################################################################
      #                              Home Manager                              #
      ##########################################################################

      # Attrset of custom home-manager modules.
      hmModules =
        let
          moduleList  = import ./modules/home-manager/list.nix;
          profileList = import ./profiles/home-manager/list.nix;
        in
          pathsToImportedAttrs moduleList // {
            profiles = pathsToImportedAttrs profileList;
          };


      ##########################################################################
      #                                 NixOS                                  #
      ##########################################################################

      # Attrset of custom NixOS modules.
      nixosModules =
        let
          moduleList  = import ./modules/nixos/list.nix;
          profileList = import ./profiles/nixos/list.nix;
        in
          pathsToImportedAttrs moduleList // {
            profiles = pathsToImportedAttrs profileList;
          };

      # Attrset NixOS configurations buildable with nixos-rebuild.
      nixosConfigurations =
        let
          importConfiguration = hostName: nixpkgs.lib.nixosSystem {
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
            modules = let
              # Home Manager's NixOS module.
              inherit (home.nixosModules) home-manager;
              # Simple inline module for sane defaults.
              common = {
                imports = [./profiles/nixos/common.nix];
                nix.nixPath = [
                  "nixpkgs=${nixpkgs}"
                  "nixpkgs-unstable=${nixpkgs-unstable}"
                ];
                networking.hostName = hostName;
              };
              # The host's configuration (it's just a module).
              host = import (./configs/nixos + "/${hostName}.nix");
              # All the NixOS modules defined in this repo.
              flakeModules = import ./modules/nixos/list.nix;

            in flakeModules ++ [ home-manager common host ];
          };
        in recImport {
          dir = ./configs/nixos;
          _import = importConfiguration;
        };

      ##########################################################################
      #                                 NixOps                                 #
      ##########################################################################
      #
      # NOTE (06/02/21)
      # NixOps master only supports deploying from the fixed flake output
      # fragment of `nixopsConfigurations.default`. This behaviour is hardcoded
      # in `eval-machines-info.nix`. Later, I hope flakes will support multiple
      # networks, each deployable by selecting it's flake output fragment e.g.
      #
      # $ nixops create -d my-net --flake "path/to/flake#my-net"

      # Attrset of deployable NixOps network configurations.
      nixopsConfigurations.default = {
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
            imports = let
              # Home Manager's NixOS module.
              inherit (home.nixosModules) home-manager;
              # Simple inline module for sane defaults.
              common = {
                imports = [./profiles/nixos/common.nix];
                nix.nixPath = [
                  "nixpkgs=${nixpkgs}"
                  "nixpkgs-unstable=${nixpkgs-unstable}"
                ];
                # NOTE This seems to work in lieu of a specialArgs option.
                nixpkgs.pkgs = pkgs;
              };
              # All the NixOS modules in this repo.
              flakeModules = import ./modules/nixos/list.nix;
            in flakeModules ++ [ home-manager common ];
          };

      # Import the nixops network configs.
      } // import ./configs/nixops (inputs // {
        inherit pkgs unstablePkgs secrets shared utilities;
      });

      ##########################################################################
      #                   Development/Deployment Environment                   #
      ##########################################################################

      # A Nix Shell containing a nixops capable of deploying the above networks.
      devShell.${system} = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.git
          pkgs.git-crypt
          pkgs.nixFlakes
          nixops-plugged.packages.${system}.nixops-plugged#nixops-hetznercloud
        ];

        shellHook = ''
          mkdir -p data/secret

          # use gpg-agent to handle SSH in this shell
          export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
          gpgconf --launch gpg-agent
        '';

        NIX_CONF_DIR = let
          current = nixpkgs.lib.optionalString
            (builtins.pathExists /etc/nix/nix.conf)
            (builtins.readFile /etc/nix/nix.conf);

          nixConf = pkgs.writeTextDir "opt/nix.conf" ''
            ${current}
            experimental-features = nix-command flakes ca-references
          '';
        in "${nixConf}/opt";
      };

  };
}
