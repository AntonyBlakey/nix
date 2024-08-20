{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.wezterm ];
    file = {
      ".wezterm.lua".source = ./wezterm.lua;
    };
  };
}
