{ pkgs, ... }:

{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {

    stateVersion = "23.05";

    packages = [
      pkgs.nixpkgs-fmt
      pkgs.rnix-lsp

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    file = {
      ".p10k.zsh".source = ./p10k.zsh;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

  };

  programs = {

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    jq.enable = true;

    # starship = {
    #   enable = true;
    #   settings = {
    #     add_newline = false;

    #     character = {
    #       success_symbol = "[>](bold green)";
    #       error_symbol = "[x](bold red)";
    #       vimcmd_symbol = "[<](bold green)";
    #     };

    #     package.disabled = true;
    #   };
    # };

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
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
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
        				if [[ $(uname -m) == 'arm64' ]]; then
        				     eval "$(/opt/homebrew/bin/brew shellenv)"
        				fi
        			'';
    };
  };

}
