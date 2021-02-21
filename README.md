# Nix Configs
This repository contains all my [Nix][1] configs and represents my personal infrastructure, packaged as a Nix flake. In general it serves as a useful example of packaging with flakes, and you can reference any of my outputs as inputs to your own flakes or just clone the repository and modify it for your own needs. I've exported loads of cool things including:

- library functions
- Nixpkgs packages & overlays
- [Home Manager][2] modules
- [NixOS][3] modules & configurations
- [NixOps][4] network configuration

For the full list run `nix flake show`.

## Outputs and Usage

### Nixpkgs Packages
I have a couple of custom nix packages such as my cv, scripts and so on that are not suitable for nixpkgs. Derivations for these packages are declared in `packages/`, along with a single overlay which includes them in any package set it is applied on. You can build individual packages by their name in the overlay e.g. to build my blog:
```bash
  λ cd the-nix-files
  λ nix build ".#lukebentleyfox-net"
```
You can also reference these packages in another flake e.g. fira code nerdfont package: `inputs.the-nix-files.packages.x86_64-linux.firacode-nerdfont`.

### Nixpkgs Overlays
All overlays for nixpkgs are declared in `overlays/`. The aforementioned custom packages overlay is symlinked into this directory and included in the export.

### Home Manager Configurations (WIP)
Home Manager configurations are declared in configuration files located at `configs/homes/<name?>.nix`. I only use Home Manager on NixOS systems so you can't just deploy these configs with some sort of `home-manager switch --flake` (yet), and I haven't provided a `hmConfigurations` output attribute for this reason. The key to understanding how I use Home Manager is my user-manager NixOS module. It acts as a layer above `users.users` and `home-manager.users` making explicit the coupling between both definitions by deriving them both from its own configuration options interface. Users set their home manager configuration this way.

### NixOS Host Configurations
The nixosConfigurations output is an attrset of buildable NixOS configuration objects. Each host is declared with a NixOS configuration file located at `configs/hosts/<name?>.nix` and is defined purely by the profiles it imports. Deploy any NixOS host configuration locally with:
``` bash
 λ cd the-nix-files
 λ nixops-rebuild --flake ".#<name?>"
```
Symlinking this repo to `/etc/nixos` enables me to rebuild my system with a simple `nixos-rebuild`.

### NixOps Network Configuration(s)
The flake output `nixopsConfigurations` is an attribute set of NixOps networks. A network is declared with a NixOps configuration file located at `configs/nixops/<name>.nix`. NixOS configs can be reused in NixOps machine definitions. At the moment NixOps only supports deploying the single network at the fixed flake output fragment `nixopsConfigurations.default`.
```bash
  λ cd the-nix-files
  λ nix develop # gives you a shiny nixops
  λ nixops create -d my-net --flake "."
  λ nixops deploy -d my-net
```
I use NixOps to manage a simple webserver on Hetzner Cloud.

## Design

### Modules Vs. Profiles
In the NixOS module system a module is a nix expression which contains configuration option declarations and definitions. This flake exports custom NixOS and Home Manager modules at the flake outputs `nixosModules` and `hmModules` respectively. A profile, on the other hand, is a made up construct which I'll define as a module with no declarations, only definitions. Not all options are created equal, and as there are separate modules for Home Manager and NixOS configurations, so are there separate profiles.
- Home Manager profiles bundle together related home-manager option definitions. These get imported in my Home Manager home declarations.
- NixOS profiles bundle together related system configuration definitions. These get imported in my NixOS host configurations or NixOps machine configurations.
- NixOps profiles bundle together related network resource definitions or nixops-specific configuration option definitions such as `deployment.*`. These get imported in my NixOps network configuration.

### Data
My infrastructure has two kinds of data; shared and secret. Shared data (e.g. ssh public keys) are imported at the top level in flake.nix, and passed to configurations via the nixos module system. Secret data are handled as follows:
- Secrets are encrypted/decrypted on pushes/pulls with github. This allows me to store secrets in this public repository along with everything else. This is achieved via git-crypt, using my personal gpg key.
- Secrets are encrypted into the nix store and decrypted on configuration activation using the target host's ssh key so only the target will be to decrypt the secrets in it's world-readable nix store. This is achieved with a custom nixos module, which sources the public key automatically if deploying via nixops, or from the shared data in this repository if deploying via nixos-rebuild. This is really great, and I highly recommend you [read about it][5].

---
#### Credit / See more like this.
- [Shabka](https://github.com/kalbasit/shabka)
- [Nixflk](https://github.com/nrdxp/nixflk)
- [Nixos-configs](https://github.com/Xe/nixos-configs)
- [the-glorious-dotfiles](https://github.com/manilarome/the-glorious-dotfiles)

[1]: https://nixos.org
[4]: https://github.com/nix-community/home-manager
[2]: https://github.com/nixos/nixpkgs
[3]: https://github.com/nixos/nixops
[5]: https://christine.website/blog/nixos-encrypted-secrets-2021-01-20
