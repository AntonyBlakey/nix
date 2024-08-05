_: {
  config = {
    opts = {
      # vim.opt.* # vim.o # set
    };
    plugins = {
      harpoon = {
        enable = true;
      };
      telescope = {
        enable = true;
        keymaps."<leader>ff" = "find_files";
        keymaps."<leader>fg" = "live_grep";
        keymaps."<leader>fb" = "buffers";
        keymaps."<leader>fh" = "help_tags";
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
      };
    };
  };
}
