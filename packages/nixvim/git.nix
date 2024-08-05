{ pkgs, ... }:
{
  config = {
    plugins = {
      fugitive.enable = true; # git wrapper # kickstart
    };
    extraPlugins = [
      pkgs.vimPlugins.rhubarb # github wrapper # kickstart
    ];
  };
}
