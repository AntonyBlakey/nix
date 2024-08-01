{ pkgs, ... }: {

  xdg.enable = true;

  home = {

    stateVersion = "24.05";

    packages = with pkgs; [
      # anything you enable in programs will be installed here
      curl
      jq
      nixpkgs-fmt
      nil
      gh
      fzf
      bat
      starship
      lazygit
      devbox
      hyperfine
    ];

    file = {
      ".config/starship.toml".source = ./starship.toml;
    };

  };

  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    nixvim = {
      #   # https://github.com/nix-community/nixvim?tab=readme-ov-file
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };

      extraPlugins = [ pkgs.vimPlugins.gruvbox ];
      colorscheme = "gruvbox";

      plugins = {
        lightline.enable = true;
        which-key.enable = true;
        comment.enable = true;
        surround.enable = true;
        telescope.enable = true;
        oil.enable = true;
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "Antony Blakey";
      userEmail = "antony.blakey@gmail.com";
      extraConfig = {
        credential = {
          "https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
          "https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      shellAliases = {
        view = "vim -R";
      };
      zplug = {
        enable = true;
      };
      initExtra = ''
                zplug "zsh-users/zsh-completions"
                zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:2
                zplug "zsh-users/zsh-history-substring-search", from:github, defer:2
                zplug "plugins/git", from:oh-my-zsh
                zplug "plugins/sudo", from:oh-my-zsh
                zplug "agkozak/zsh-z"
                if ! zplug check; then
                  zplug install
                fi
                zplug load
                alias cat=bat
                source <(fzf --zsh)
                source <(starship init zsh)
        			'';
    };
  };

}
