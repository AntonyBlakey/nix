{ pkgs, config, inputs, lib, ... }: {

  xdg.enable = true;

  home = {

    stateVersion = "24.05";

    packages = with pkgs; [
      pkgs.curl
      pkgs.jq
      pkgs.nixpkgs-fmt
      pkgs.nil
      pkgs.gh
      pkgs.fzf
      pkgs.bat
      pkgs.starship
      pkgs.lazygit
      pkgs.devbox
      pkgs.hyperfine
      pkgs.nixvim

      pkgs.kitty

      pkgs.ksvim
      pkgs.lzvim
      pkgs.nvchad
      pkgs.aovim
      pkgs.lnvim
      pkgs.spvim
      pkgs.vim-distro-format

      # pkgs.nix-inspect
    ];

    file = {
      ".config/starship.toml".source = ./starship.toml;
      ".config/kitty/kitty.conf".source = ./kitty.conf;
      ".config/kitty/current-theme.conf".source = ./current-theme.conf;
    };

    # Need to create aliases because Launchbar doesn't look through symlinks.
    activation.link-apps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      nix_apps="$HOME/Applications/Home Manager Apps"
      new_nix_apps="$HOME/Applications/Nix"

      echo "setting up $new_nix_apps ..." >&2

      rm -rf "$new_nix_apps"
      mkdir -p "$new_nix_apps"

      for src in "$nix_apps"/**.app ; do
        dest=$(basename "$src")
        /usr/bin/osascript -e "
          use framework \"Foundation\"
          set theAliasPath to \"$src\"
          set theURL to current application's NSURL's fileURLWithPath: theAliasPath
          set { resolvedURL, resolveError } to current application's NSURL's URLByResolvingAliasFileAtURL:theURL options:0 |error|: (reference)
          if resolveError is missing value then
            set resolvedPath to POSIX file (resolvedURL's |path|() as text) as alias
            set theNIXDirectory to POSIX file \"$new_nix_apps\"
            tell application \"Finder\"
                make new alias file to resolvedPath at theNIXDirectory
                set name of result to \"$dest\"
            end tell
          else
          end if
        " 1>/dev/null

        # This was my fallback ...
        # echo 'tell application "'$src'" to activate' | /usr/bin/osacompile -o "$new_nix_apps/$dest" -
      done
    '';
  };

  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

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

    # nixvim = {
    #   #   # https://github.com/nix-community/nixvim?tab=readme-ov-file
    #   enable = true;
    #   defaultEditor = true;
    #   viAlias = true;
    #   vimAlias = true;

    #   opts = {
    #     number = true;
    #     relativenumber = true;
    #     shiftwidth = 2;
    #   };

    #   extraPlugins = [ pkgs.vimPlugins.bluloco-nvim pkgs.vimPlugins.lush-nvim ];
    #   colorscheme = "bluloco-light";

    #   plugins = {
    #     lightline.enable = true;
    #     which-key.enable = true;
    #     comment.enable = true;
    #     surround.enable = true;
    #     telescope.enable = true;
    #     oil.enable = true;
    #   };
    # };

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

