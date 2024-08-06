_: {
  config = {
    opts.laststatus = 3; # only one statusline at the bottom
    #highlightOverride.WinSeparator.guibg = "None"; # fix separators # FIXME doesn't work

    plugins = {
      lualine.enable = true; # lazyvim, lunarvim, kickstart
      #airline.enable = true;
      #lightline.enable = true;
      #
    };
    #extraPlugins = [ # nvchad
    #  pkgs.vimPlugins.nvchad
    #  pkgs.vimPlugins.nvchad-ui
    #];
    #extraPlugins = [ # astrovim
    #  pkgs.vimPlugins.heirline-nvim # framework to create a statusline
    #];
  };
}
