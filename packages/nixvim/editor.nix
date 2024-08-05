{ pkgs, ... }: {
  config = {
    opts = {
      # vim.opt.* # vim.o # set
      undofile = true; # saves to $XDG_STATE_HOME/nvim/undo
      # undolevels = 1000;
      # undoreload = 10000;

      relativenumber = true;

      signcolumn = "yes"; # reserves space for diagnostic icons

      shiftwidth = 2;
    };
    plugins = {
      treesitter.enable = true; # lang parsing
      oil.enable = true; # directory browser, intsead of netrw
      surround.enable = true; # Shortcuts for setting () {} etc.
      lastplace.enable = true; # restore cursor position
    };
    extraPlugins = [
      pkgs.vimPlugins.vim-sleuth # detect tabstop and shiftwidth automatically # kickstart
    ];
  };
}
