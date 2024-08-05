inputs:
(
  final: prev:
  import ../packages {
    pkgs = final;
    inherit inputs;
  }
)
