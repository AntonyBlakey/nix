{ pkgs, ... }:
{
  config = {
    viAlias = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;

    extraConfigVim = '''';

    extraConfigLua = '''';

    extraConfigLuaPre = '''';

    extraConfigLuaPost = '''';

    extraPackages = [ ];
    # extraLuaPackages = [ ];

    opts = {
      # vim.opt.* # vim.o # set
    };
    localOpts = {
      # vim.opt_local.* # setlocal
    };
    globalOpts = {
      # vim.opt_global.* # setglobal
    };

    globals = {
      # vim.g.*
      mapleader = " ";
      maplocalleader = " ";
    };

    match = { };

    keymaps = [
      #{
      #  action = "";
      #  key = "";
      #  #lua = true;
      #  mode = "";
      #  options = {
      #    desc = "";
      #  };
      #}
    ];

    ### theme

    extraPlugins = [
      pkgs.vimPlugins.bluloco-nvim
      pkgs.vimPlugins.lush-nvim
    ];
    colorscheme = "bluloco-dark";
    # colorschemes = {
    # gruvbox = {
    # enable = true;
    # settings = {
    #   contrastDark = "hard";
    # };
    # };
    # };
  };
}
