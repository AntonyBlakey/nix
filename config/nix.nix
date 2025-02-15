{ lib, pkgs, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    gc.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "antony"
      ];
      # auto-optimise-store = true; # maybe causes build failures
    };
  };
}
