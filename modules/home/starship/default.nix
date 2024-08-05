{ pkgs, ... }: {
  home = {
    packages = [ pkgs.starship ];
    file = { ".config/starship.toml".source = ./starship.toml; };
  };
}

