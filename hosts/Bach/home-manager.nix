{ pkgs, ... }: {

  xdg.enable = true;

  home = {

    stateVersion = "24.05";

    packages = with pkgs; [
      # anything you enable in programs will be installed here
    	curl
      jq
      git-credential-manager
      nixpkgs-fmt
      nil
    ];

    file = {
      ".p10k.zsh".source = ./p10k.zsh;
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

      plugins.lightline.enable = true;
      plugins.which-key.enable = true;
      plugins.comment.enable = true;
      plugins.surround.enable = true;
      plugins.telescope.enable = true;
      plugins.oil.enable = true;
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
          credentialStore = "keychain";
          helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
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
      # homebrew changed dirs on arm64
      initExtra = ''
        zplug "zsh-users/zsh-completions"
        zplug romkatv/powerlevel10k, as:theme, depth:1
        zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:2
        zplug "zsh-users/zsh-history-substring-search", from:github, defer:2
        zplug "plugins/git", from:oh-my-zsh
        zplug "plugins/sudo", from:oh-my-zsh
        if ! zplug check; then
          zplug install
        fi
        zplug load
        source ~/.p10k.zsh
			'';
    };
  };

}