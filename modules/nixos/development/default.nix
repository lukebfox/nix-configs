{ config, lib, pkgs, unstablePkgs, ... }:

let
  inherit (builtins) attrValues;
  inherit (lib) mkIf mkMerge mkOption mkEnableOption types;

  cfg = config.modules.development;
in
{

  ##### interface

  options = {
    modules.development.enable = mkEnableOption "Enable system module for development.";

    /*  Language support submodule. Mostly contains packages required
        to bootstrap a project, as project-specific dependencies and tools
        will be defined locally in a shell.nix or devShell flake output.
    */
    modules.development.languages = {
      cpp        = mkEnableOption "Development support for C++.";
      haskell    = mkEnableOption "Development support for Haskell.";
      javascript = mkEnableOption "Development support for Javascript.";
      latex      = mkEnableOption "Development support for LaTeX.";
      nix        = mkEnableOption "Development support for Nix.";
      python     = mkEnableOption "Development support for Python.";
      ruby       = mkEnableOption "Development support for Ruby.";
      rust       = mkEnableOption "Development support for Rust.";
      terraform  = mkEnableOption "Development support for Terraform.";
    };
  };

  ##### implementation

  config = mkIf cfg.enable (mkMerge [

    {
      # Install devman pages
      documentation.dev.enable = true;

      # Language API browser
      environment.systemPackages = [ unstablePkgs.devdocs-desktop ];
    }

    ############################### C++ ##############################

    (mkIf cfg.languages.cpp { })

    ############################# Haskell ############################

    (mkIf cfg.languages.haskell {
      environment.systemPackages = [ unstablePkgs.cachix ];
    })

    ########################### Javascript ###########################

    (mkIf cfg.languages.javascript {
      environment.systemPackages = [
        unstablePkgs.nodejs
        unstablePkgs.nodePackages.node2nix
      ];
    })

    ############################## LaTeX #############################

    (mkIf cfg.languages.latex {
      environment.systemPackages = [ pkgs.texlive.combined.scheme-full ];
    })

    ############################### Nix ##############################

    (mkIf cfg.languages.nix {
      environment.systemPackages = attrValues {
        inherit (unstablePkgs)
          nix-index
          nix-prefetch-git;
      };
    })

    ############################# Python #############################

    (mkIf cfg.languages.python {

      environment.systemPackages = [ unstablePkgs.poetry ];
      /*
      # Use better python repl
      environment.sessionVariables = {
        PYTHONSTARTUP =
          writers.writePython3
            "ptpython.py"
            { libraries = [ pythonPackages.ptpython ]; }
            ''
            from __future__ import unicode_literals
            from pygments.token import Token
            from ptpython.layout import CompletionVisualisation

            import sys

            ${builtins.readFile ./ptconfig.py}

            try:
                from ptpython.repl import embed
            except ImportError:
                print("ptpython is not available: falling back to standard prompt")
            else:
                sys.exit(embed(globals(), locals(), configure=configure))
            '';
      };
      */
    })

    ############################## Ruby ##############################

    (mkIf cfg.languages.ruby {
      environment.systemPackages = attrValues {
        inherit (unstablePkgs)
          ruby
          bundler
          bundix;
      };
    })

    ############################## Rust ##############################

    (mkIf cfg.languages.rust {
      environment.systemPackages = [ unstablePkgs.crate2nix ];
    })

    ############################ Terraform ###########################
    # REVIEW 14/10/20 deprecate?

    (mkIf cfg.languages.terraform {
      environment.systemPackages = attrValues {
        inherit (unstablePkgs)
          terraform
          terraform_hcloud;
      };
    })

  ]);

}
