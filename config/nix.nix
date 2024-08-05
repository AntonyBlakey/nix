_: {
  nix = {
    # package = lib.mkDefault pkgs.nix;
    gc.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # auto-optimise-store = true; # maybe causes build failures
    };
  };
}
