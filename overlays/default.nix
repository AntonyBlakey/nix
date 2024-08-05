inputs: rec {
  # all-channels = final: prev: {
  #   stable = import inputs.nixos-stable {
  #     system = prev.stdenv.hostPlatform.system;
  #     #overlays = [ ];
  #     config = import ./nixpkgs/config.nix;
  #   };
  #   unstable = import inputs.nixos-unstable {
  #     system = prev.stdenv.hostPlatform.system;
  #     #overlays = [ ];
  #     config = import ./nixpkgs/config.nix;
  #   };
  # };
  # nixpkgs-update = (final: prev: inputs.nixpkgs-update.packages.${prev.stdenv.hostPlatform.system} or { });
  # devenv = (final: prev: {
  #   devenv = inputs.devenv.packages.${prev.stdenv.hostPlatform.system}.devenv;
  # });
  local-packages = (
    final: prev: (import ../packages/single-system.nix inputs prev.stdenv.hostPlatform.system)
  );
  default = inputs.lib.composeManyExtensions [
    # all-channels
    local-packages
    # rclonefs
    # nixpkgs-update
    # devenv

    # inputs.nur.overlay
    # inputs.rust-overlay.overlays.default
    # inputs.nix-alien.overlays.default
  ];
}
