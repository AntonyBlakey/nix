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
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

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

    starship = {
      enable = true;
      settings = {
        add_newline = false;

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[x](bold red)";
          vimcmd_symbol = "[<](bold green)";
        };

        package.disabled = true;
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
          credentialStore = "secretservice";
          helper = "${pkgs.git-credential-manager}/bin/git-credential-manager-core";
        };
      };
    };

    zsh = {
      enable = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        view = "vim -R";
      };
      # homebrew changed dirs on arm64
      initExtra = ''
        				if [[ $(uname -m) == 'arm64' ]]; then
        				     eval "$(/opt/homebrew/bin/brew shellenv)"
        				 fi
        			'';
    };

  };

}
