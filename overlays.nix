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
  local-packages = (final: prev: import ./packages { pkgs = final; inherit inputs; });
  # nixpkgs-update = (final: prev: inputs.nixpkgs-update.packages.${prev.stdenv.hostPlatform.system} or { });
  # rclonefs = (final: prev: {
  #   rclone = (prev.symlinkJoin {
  #     # create filesystem helpers until https://github.com/NixOS/nixpkgs/issues/258478
  #     name = "rclone";
  #     paths = [ prev.rclone ];
  #     postBuild = ''
  #       ln -sf $out/bin/rclone $out/bin/mount.rclone 
  #       ln -sf $out/bin/rclone $out/bin/rclonefs
  #     '';
  #   });
  # });
  # devenv = (final: prev: {
  #   devenv = inputs.devenv.packages.${prev.stdenv.hostPlatform.system}.devenv;
  # });
  default = inputs.nixpkgs.lib.composeManyExtensions [
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
