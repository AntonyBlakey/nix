{ pkgs, ... }:
{

  home = {

    stateVersion = "24.05";

    packages = with pkgs; [
      nixpkgs-fmt
      nil
  		vim
  		curl
  		jq
      devenv

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

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    jq.enable = true;

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
			'';
    };
  };

}
