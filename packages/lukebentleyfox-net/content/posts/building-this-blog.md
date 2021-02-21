+++
title="Building and deploying a blog with Zola and Nix Flakes"
description="Nix level: Beginner"
date=2020-10-09
draft=false
[taxonomies]
tags = ["nix", "flakes", "nixops", "zola"]
categories = ["tutorial"]
+++

[Nix](https://nixos.org/) is a powerful tool which I use all the time as a software developer. In this article I'll show you how to use it along with a nimble static site generator called [Zola](https://www.getzola.org/) to build and deploy a blog. Along the way we will write the tiniest of derivations, and you'll get a glimpse into the power of flakes.<!-- more --> If you have absolutely zero experience with Nix, then I heartily recommend going through the first 5 [Nix Pills](https://nixos.org/guides/nix-pills/pr01.html) before coming back here. It won't take long and you'll be in a better position to understand everything I talk about here.

## Static site generators
SSGs are programs which generate all the public assets for your site from source files using templating. Zola is a static site generator written in rust, capable of compiling sass. I'm more interested in providing content than making a supercharged site, so I don't need the most powerful SSG. Having said that, Zola can do quite a lot. It has a simple templating system, is super fast, and has no dependencies, which makes it a breeze to work with. It comes with a selection of [themes](https://www.getzola.org/themes/) you can tweak to get your blog looking good in no time. 

## Nix & Flakes
Nix has many hats: it's a language, a package manager, an ecosystem and more. I started using Nix only 2 years ago and now it is in everything I do. As a language Nix is purely functional and dynamically typed. I also mentioned that Nix is a package manager. Once I was satisified with my blog, I packaged it with Nix. I did this because it gives me builds and deploys for free. A Nix package is represented by a *derivation*, which is described using the Nix language. NixOS is a linux distribution built on top of the Nix package manager from the idea that everything can be packaged with Nix, even the operating system. NixOps is a tool for deploying NixOS machines into the cloud. NixOS machines and NixOps networks are specified declaratively, just like Nix packages.

Flakes are a new feature of Nix, meant to simplify and extend the packaging of Nix projects like this. Previously Nix used to ship different releases of nixpkgs in their own *channels*, such that you could add a channel to your system and get access to its nixpkgs in your nix expressions. This was an issue for portability... when I give you my nix files, how do you know what version of nixpkgs it was written for? The dependency is implicit, which is anti-nix! One goal for flakes is the ability to build any project no matter what version of nixpkgs you have locally installed.

# Setting up the environment
In a fresh git repository, make a new file at the root called `flake.nix`. This required file lets Nix know that this repository contains a project packaged as a Nix Flake.

<div class='filename'>
  <div>flake.nix</div>
</div>

```nix
{
  description = "lukebentleyfox.net flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url   = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    let
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [self.overlay];
      };
    in {
      overlay = final: prev: {
        blog = prev.callPackage ./blog {};
      };

    } // utils.lib.eachDefaultSystem (system:
      let pkgs = pkgsFor system;
      in {
        defaultPackage = pkgs.blog;

        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.zola ];
        };
      });
}
```
Let's unpack this file real quick.

##### Inputs: an attribute set (attrset) of input sources.
This is where we specify the flake's dependencies i.e nixpkgs. Note: the nixpkgs input URI is shorthand for `"github:NixOS/nixpkgs/nixos-unstable"`. We've also pulled in another flake, [flake-utils](https://githb.com/numtide/flake-utils), to use some handy functions it exports.

##### Outputs: a function from realised inputs to an attrset of flake outputs.
These outputs can be library functions, Nix packages, development environments, Nixpkgs overlays, NixOS modules, NixOS machines and even NixOps networks! This flake however, simply outputs a package, an overlay, and a development environment.

<!-- ![unlimitedpower](../../../images/unlimitedpower.png) -->

Our outputs attrset is the result of merging two attrsets with `//`. The first attrset only contains the overlay output. This overlay will include our blog in any package set it's applied to, and uses `callPackage` to generate a package from our blog's derivation file which we are yet to write. The function `pkgsFor` defined above takes a system, and returns such a package set including our blog. Notice that the body for `pkgsFor` refers to `self`, which itself is an attrset of all the flake's realised outputs. The second attrset containing outputs is built using the `eachDefaultSystem` utility function. This takes a function from a system, to an attrset and returns an attrset suitable for flake outputs. It essentially maps our function over any systems it knows about, generating your outputs for the most common architectures. If you also want to manage your blog from windows or some niche system then you'll be want to use `eachSystem` instead. Our `pkgsFor` function is used now to get a package set with our blog in it no matter what system we are using, so you can build your blog on macOS as easily as on linux. The defaultPackage output is what gets built when we run `nix build`, and the devShell output represents an environment we can enter with `nix develop`. By adding zola to `buildInputs` we can run commands like `zola serve` when inside this environment.

You can check your flake is correctly written with `nix flake check`. When you run this for the first time it will also write you a flake.lock file which pins your inputs to the latest commit on the branch you specified {% hint(id=1) %}If you want to update the flake's inputs later on, `nix flake update` will relock the inputs.{% end %}. If you run this on the flake above you'll get a fat error because we haven't create our blog derivation yet; before we do that, let's write a blog.

# Writing the blog
Like me, Nix is **lazy**. This means we can still enter our dev environment, despite the fact one of our flakes outputs is garbage.
Let's make a blog:
```bash
λ nix develop
λ zola init blog
λ cd blog
λ zola serve
```
Cool! Not much to see at `http://localhost:1111` though. Now is the time to let your creative side free on this repo! Zola has great [documentation](https://www.getzola.org/documentation/getting-started/overview/#home-page). When you've finished writing your blog, continue reading.

# Building the blog
You may have noticed that while you are inside the nix shell you can build your blog with `zola build`. Building your blog with nix works much the same way. In order to set this up, you'll need to write that derivation we talked about. Here's a `default.nix` I made earlier, placed in the blog's subdirectory.

<div class='filename'>
  <div>blog/default.nix</div>
</div>

```nix
{ pkgs, stdenv, ... }:
stdenv.mkDerivation rec {
  pname = "my-cool-blog";
  version = "0.0.1";
  src = ./.;
  buildInputs = [ pkgs.zola ];
  buildPhase = ''
    zola build
  '';
  installPhase = ''
    cp -r public $out
  '';
}
```
When nix builds a package, it does so in a fresh tmp directory, with all the relevant dependecies in its PATH. I've specified two (of the several possible) phases for the building of this package: 
* buildPhase: Here the builder has access to dependencies from `buildInputs`. All it does is run zola to compile the blog. If your blog is broken, nix will show you zola's output when it fails.
* installPhase: At this point the builder copies the generated static assets from `./public` in the build directory, into the output directory, which is the Nix store path of the built package.

Now when you run `nix flake check` from the project root you'll get no errors {% hint(id=2) %}You can view a flake's outputs with `nix flake show 'path/to/flake'`.{% end %}. You can build your flake with `nix build`, and watch your site get compiled. Nix is nice enough to symlink the resulting nix store package locally at `./result` so you can cd into it and have a poke around.

## Deploying the blog
So we know how to build the blog, now we want to deploy it. By leveraging Nix Flakes, we get the ability to both build **and** deploy the blog in one command, who said you can't have your cake and eat it too?

We're going to have to beef up our flake.nix in order to be able to deploy this flake. We'll want the latest NixOps as our deploy tool, so we'll declare that dependency in our flake inputs, and add the package it exports to `devShell` so that we can use it. The flake I've added to my inputs is a wrapper around NixOps which bundles it with lots of plugins, including the [nixops-hetznerloud](https://github.com/lukebfox/nixops-hetznercloud) plugin which we need to deploy the blog to Hetzner Cloud {% hint(id=3) %}To see what plugins you can use run `nixops list-plugins`. This flake exports other outputs which you can use to package nixops with any combination of plugins.{% end %}.

<div class='filename'>
  <div>flake.nix</div>
</div>

```nix
{
  description = "lukebentleyfox.net flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixops-plugged.url  = "github:lukebfox/nixops-plugged";
    utils.url   = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, nixops-plugged, utils, ... }:
    let
      domain = "lukebentleyfox.net";
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [self.overlay];
      };

    in {
      overlay = final: prev: {
        blog = prev.callPackage ./blog {};
      };
      
      nixopsConfigurations.default = {
        inherit nixpkgs;
        network.description = domain;
        defaults.nixpkgs.pkgs = pkgsFor "x86_64-linux";
        defaults._module.args = {
          inherit domain;
        };
        webserver = import ./machine;
      };

    } // utils.lib.eachDefaultSystem (system:
      let pkgs = pkgsFor system;
      in {
        defaultPackage = pkgs.blog;

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.zola
            nixops.defaultPackage.${system}
          ];
        };
      });
}
```
Hang on, what's that other stuff in outputs? I've defined a new output, nixopsConfigurations, which isn't documented, but *is* in the NixOps codebase! This output is an attrset of NixOps network expressions. Currently nixops only supports deploying from the fixed flake output fragment `#nixopsConfigurations.default`, but this isn't a problem, as we'll only define one network. The `defaults.*` options are applied to all machines in our network, which means we can modularly set the package set to one including our blog using `pkgsFor` like before, except hardcoded to the system that NixOS is based on. We also want to be able to use our domain name throughout our codebase, defining it once at the top level and adding it to the arguments which get passed to each network expression. Finally, we declare a machine called webserver as the imported value of `machine/default.nix`, which is a NixOS module specifying the configuration for the virtual host which we will deploy on. It is the simplest type of module, as we won't declare any new options, we are only going to provide definitions for existing ones. Actually strictly speaking it is a NixOps configuration because we are going to use the `deployment.*` options which are only available as part of a NixOps network evaluation.

<div class='filename'>
  <div>machine/default.nix</div>
</div>

```nix
{ config, lib, domain, ... }: #1
let
  inherit (lib) fileContents; #2
in
{
  deployment = {
    targetEnv = "hetznercloud";
    hetznerCloud = { #3
      apiToken = fileContents ../secrets/hetzner-api-key;
      location = "nbg1";
      serverType = "cx11";
    };
    keys.acme-dns-creds = { #4
      text = fileContents ../secrets/acme-dns-creds;
      user = "acme";
      group = "acme";
      permissions = "0640";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ]; #5

  security.acme = { #6
    acceptTerms = true;
    email = "admin+acme@${domain}";
    certs."${domain}" = {
      domain = "*.${domain}";
      extraDomainNames = [domain];
      dnsProvider = "cloudflare";
      credentialsFile = "/run/keys/acme-dns-creds";
      dnsPropagationCheck = true;
    };
  };

  services.nginx = { #7
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    virtualHosts."${domain}" = {
      useACMEHost = domain;
      forceSSL = true;
      locations."/".root = config.nixpkgs.pkgs.blog;
      extraConfig = "error_page 404 /404.html;";
    };
  };

  users.groups.acme.members = ["nginx"]; #8
}
```
Going through this configuration step by step:
1. All modules take a standard argument set, which we augmented in our flake.nix to include our domain. We can split this up into smaller files, and each one will still have the `domain` argument.
2. The `inherit` keyword causes the specified attributes to be bound to whatever variables with the same name happen to be in scope, where the braces identify the scope. Here, it's equivalent to `"fileContents = lib.fileContents;"`, and it's good practice to use this technique instead of the `with` keyword for bringing variables into scope, because `inherit` won't evaluate the entirety of `lib`, just the function you wanted.
3. Hetzner Cloud specific option definitions. We provide NixOps with the api key it needs to authenticate to the Hetzner Project we want to deploy to, and specify the simplest server in Nuremberg, their primary location. More options can be browsed [here](https://github.com/lukebfox/nixops-hetznercloud).
4. NixOps secrets. All the output from our deployment is going to end up in the target host's nix store, world readable, which means we need another way to manage secrets. NixOps provides the `deployment.keys.*` option for secrets which won't get stored in the nix store, but rather stored at `/run/keys/`, with permissions we can control. We *still* don't want to have secrets in plaintext in our config files though, in case we want to store them on github, so we'll use git-crypt to encrypt everything in a `secrets` directory, and import the files where needed with `fileContents`.
5. Let's open up the HTTP/(S) ports so we can serve the blog. NixOps will open up the SSH port for us, and also take care of hardware specific configuration options.
6. Here we instruct the machine to use ACME to retrieve SSL certificates for our domain, via a cloudflare DNS-01 challenge so that we can use wildcard certs. This isn't actually needed here but I though I'd show you anyway, because it's what I use. Feel free to change this for your situation.
7. Here we instruct the machine to use Nginx to serve our blog. We tell it to redirect to HTTPS using the certs acme provides. We also override nginx's default 404 to serve a custom page at the root of our blog.
8. Give nginx permission to read the certificates which ACME fetched.
Phew! So much code, but we're almost done. Let's check in our work and return to our dev shell.
```bash
λ git add .
λ nix develop
```
After Nix has prepared your environment with the nixops you added since last time, you will be dropped into your dev shell, where you can create the deployment you specified in flake.nix, and deploy it.
```bash
λ nixops create -d blog --flake "."
λ nixops deploy -d blog
λ nixops info -d blog
```
After a few minutes (it takes a while the first time because it is installing NixOS on the server) your server will be serving up your blog to anyone fortunate enough to stumble across it. Which will be no-one, until you set up your dns records to point to the IP of your machine. Then you're done!

## Conclusion
Thanks to nix, `nixops deploy` is smart enough to know if you've changed your blog since last time. If you have it, will perform an incremental rebuild before deploying the blog to the server. So now, when you make some changes to your blog, just run `nixops deploy -d blog` and everything will be take care of for you. I promised it would be worth it! If you want to check out the final flake, I've got a demo [here](https://github.com/lukebfox/nix-blog-demo).

