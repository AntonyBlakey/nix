inputs: system:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config = import ../config/pkgs.nix;
    overlays = [ (import ../overlays inputs).default ];
  };
in
inputs.lib.mergeAttrsList [
  {
    # nix-inspect = inputs.nix-inspect.packages.${pkgs.stdenv.hostPlatform.system}.default;
  }
  (import ./nixvim { inherit pkgs inputs; })
  (import ./vim-distro pkgs)
]
