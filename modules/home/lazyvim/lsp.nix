_: {
  config = {
    opts = {
      # vim.opt.* # vim.o # set
    };
    plugins = {
      #TODO checkout rustaceanvim
      # lsp = {
      #   enable = true;

      #   servers = {
      #     #nil_ls.enable = true; # TODO use none_ls
      #     nixd.enable = true;
      #     rust-analyzer =
      #       let
      #         my-rust = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.my-rust-stable;
      #       in
      #       {
      #         enable = true;
      #         package = my-rust;
      #         installCargo = true;
      #         cargoPackage = my-rust;
      #         installRustc = true;
      #         rustcPackage = my-rust;
      #       };
      #   };
      # };
      cmp = {
        # TODO rewrite
        enable = true;
        #autoEnableSources = true;
        #mappingPresets = ["insert"];
        #settings.sources = [
        #  {name = "nvim_lsp";}
        #  {name = "path";}
        #  {name = "buffer";}
        #];
      };
    };
  };
}
