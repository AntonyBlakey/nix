{ config, pkgs, ... }:
{
  home.packages = [ pkgs.neovim ];
  programs.zsh.shellAliases.view = "vim -R";
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = [
      pkgs.ripgrep
      pkgs.fd
    ];
  };
  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "LazyVim";
      repo = "starter";
      rev = "main";
      sha256 = "";
    };
  };
}
