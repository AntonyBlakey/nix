{ lib, inputs, ... }: {
  imports = [ ./common.nix ];
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
