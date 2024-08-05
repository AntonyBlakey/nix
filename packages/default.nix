inputs:
let
  lib = inputs.nixpkgs.lib;
in
lib.genAttrs [ "aarch64-darwin" ] (
  system:
  let
    pkgs = import inputs.nixpkgs { inherit system; };
  in
  lib.mergeAttrsList [
    {
      # nix-inspect = inputs.nix-inspect.packages.${pkgs.stdenv.hostPlatform.system}.default;
    }
    (import ./nixvim { inherit pkgs inputs; })
    (import ./vim-distro { inherit pkgs inputs; })
  ]
)
