{ pkgs, ... }:
{
  ksvim = pkgs.callPackage ./install.nix {
    name = "ksvim";
    conf-repo-url = "https://github.com/nvim-lua/kickstart.nvim.git";
  };
  lzvim = pkgs.callPackage ./install.nix {
    name = "lzvim";
    conf-repo-url = "https://github.com/LazyVim/starter.git";
  };
  nvchad = pkgs.callPackage ./install.nix {
    name = "nvchad";
    conf-repo-url = "https://github.com/NvChad/NvChad.git";
  };
  aovim = pkgs.callPackage ./install.nix {
    name = "aovim";
    conf-repo-url = "https://github.com/AstroNvim/AstroNvim.git";
  };
  lnvim = pkgs.callPackage ./install.nix {
    name = "lnvim";
    conf-repo-url = "https://github.com/LunarVim/LunarVim.git";
  };
  spvim = pkgs.callPackage ./install.nix {
    name = "spvim";
    conf-repo-url = "https://gitlab.com/SpaceVim/SpaceVim.git";
  };
  vim-distro-clean = pkgs.callPackage ./clean.nix { };
}
