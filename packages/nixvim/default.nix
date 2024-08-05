{ pkgs, inputs }:
{
  nixvim = inputs.nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.makeNixvimWithModule {
    extraSpecialArgs = {
      inherit inputs;
    };
    pkgs = inputs.nixvim.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    module = {
      imports = [
        ./core.nix
        ./editor.nix
        ./lsp.nix
        ./git.nix
        ./lookup.nix
        ./status-line.nix
      ];
    };
  };
}
