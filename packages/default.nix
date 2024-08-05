inputs:
inputs.lib.genAttrs inputs.lib.systems.flakeExposed (
  system: import ./single-system.nix inputs system
)
