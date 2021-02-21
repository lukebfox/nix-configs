# Utility functions used across the repository.
{ lib }:
let
  inherit (builtins) attrNames attrValues baseNameOf isAttrs listToAttrs readDir;
  inherit (lib) concatStringsSep fileContents filterAttrs flatten hasSuffix
                mapAttrs mapAttrs' mapAttrsToList mkMerge nameValuePair
                removeSuffix;

in rec {

  # Generate an attribute set by mapping a function over a list of values.
  genAttrs' = values: f: listToAttrs (map f values);

  /* `filterMapAttrs`, composition of map and filter attrset transformations.
     Type: filterMapAttrs :: (name -> value -> bool )
                             (name -> value -> { name = any; value = any; })
                             Attrset
  */
  filterMapAttrs = seive: f: attrs: filterAttrs seive (mapAttrs' f attrs);

  /* `mapFilterAttrs`, composition of filter and map attrset transformations.
     Type: mapFilterAttrs :: (name -> value -> { name = any; value = any; })
                             (name -> value -> bool )
                             Attrset
  */
  mapFilterAttrs = f: seive: attrs: mapAttrs' f (filterAttrs seive attrs);

  /* Turn a directory into an nested attrset.
     Nodes are directories. Leaves are files or symlinks.

     Type: dirsToAttrs:: String -> Attrset

     Example:

     Directory with following structure:

     DIR-A-B-d
       | \-C-e
       |-F-g
       | \-h
       \-I (empty)

     dirsToAttrs /path/to/dir
     => {
          A = {
            B = {
              "d" = "/path/to/dir/A/B/d";
            };
            C = {
              "e" = "/path/to/dir/A/B/e";
            };
          };
          F = {
            "g" = "path/to/dir/F/g";
            "h" = "path/to/dir/F/h";
          };
          I = {};
        }
  */
  dirsToAttrs = dir:
    mapAttrs
      (n: v:
        (if v == "directory"
         then (dirsToAttrs "${dir}/${n}")
         else "${dir}/${n}"))
      (readDir dir);


  /* `flattenAttrs` recursively flattens a nested attrset.

    Final attrset contains only leaf nodes of initial attrset, where
    the leaf's name becomes it's concatenated parent names separated by "/",
    and the leaf value remains the same. For this reason it is well particularly
    well suited for composition with `dirsToAttrs`.

    Type: flattenAttrs :: Attrset -> Attrset

    Example:
    flattenAttrs {
      A = {
        B = {
          "d" = "/path/to/dir/A/B/d";
        };
        C = {
          "e" = "/path/to/dir/A/B/e";
        };
      };
      F = {
        "g" = "path/to/dir/F/g";
        "h" = "path/to/dir/F/h";
      };
      I = {};
    } => {
      "A/B/d" = "/path/to/dir/A/B/d";
      "A/C/e" = "/path/to/dir/A/C/e";
      "F/g"   = "/path/to/dir/F/g";
      "F/h"   = "/path/to/dir/F/h";
    };
  */
  flattenAttrs = set:
    let recurse = acc: set:
          let g = n: v:
                if isAttrs v
                then recurse (acc++[n]) v
                else nameValuePair (concatStringsSep "/" (acc++[n])) v;
          in flatten (mapAttrsToList g set);
    in listToAttrs (recurse [] set);

  /* alternatively

     PATH/TO/DIR-A-B-d
               | \-C-e
               |-F-g
               | \-h
               \-I (empty)

      "A/B/d" = "/path/to/dir/A/B/d";
      "A/C/e" = "/path/to/dir/A/C/e";
      "F/g"   = "/path/to/dir/F/g";
      "F/h"   = "/path/to/dir/F/h";

     filesUnder :: path -> [path]
     return the list of absolute paths of all files under dir


     for a directory it is defined to be concatenated results of recursive function called on each child

  */
  filesUnder = dir:
    let
      children = readDir dir;
      parse = mapAttrs (n: v: if v=="directory" then filesUnder "${dir}/${n}" else ["${dir}/${n}"] );
    in builtins.concatLists (attrValues (parse children));

  # see my awesomewm home-manager module for the above two functions in action!


  /* Convert a list to file paths to attribute set
     that has the filenames stripped of nix extension as keys
     and imported content of the file as value.
  */
  pathsToImportedAttrs = paths:
    genAttrs' paths (path: {
      name = removeSuffix ".nix" (baseNameOf path);
      value = import path;
    });

  # wysiwyg (depth 0)
  importOverlays = overlayDir:
    let
      fullPath = n: overlayDir + "/${n}";
      overlayPaths = map fullPath (attrNames (readDir overlayDir));
    in pathsToImportedAttrs overlayPaths;

  # wysiwyg (depth 0)
  importSecrets = secretsDir:
    filterMapAttrs
      (_: v: v != null)
      (n: v:
        if n != "default.nix" && v == "regular"
        then nameValuePair (n)  (fileContents (secretsDir + "/${n}"))
        else nameValuePair ("") (null))
      (readDir secretsDir);

  # Used in homes, hosts and networks for generating attrset of configurations
  # from, using an import function specific to the type of configuration.
  recImport = { dir, _import ? base: import "${dir}/${base}.nix" }:
    filterMapAttrs
      (_: v: v != null)
      (n: v:
        if n != "default.nix" && hasSuffix ".nix" n && v == "regular"
        then let name = removeSuffix ".nix" n;
             in nameValuePair (name) (_import name)
        else nameValuePair ("") (null))
      (readDir dir);

}
