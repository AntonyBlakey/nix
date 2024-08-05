{ pkgs, ... }: {
  home = {
    packages = [ pkgs.kitty ];
    file = {
      ".config/kitty/kitty.conf".source = ./kitty.conf;
      ".config/kitty/current-theme.conf".source = ./current-theme.conf;
    };
  };
}

