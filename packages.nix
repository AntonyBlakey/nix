inputs:
let
  lib = inputs.nixpkgs.lib;
in
lib.genAttrs [ "aarch64-darwin" ]
  # lib.systems.flakeExposed
  (
    system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        # config = import ./nixpkgs/config.nix;
        # overlays = [ (import ./overlays.nix inputs).default ]; # local packages are not recursive
      };
    in
    (import ./packages { inherit pkgs inputs; })
  )
