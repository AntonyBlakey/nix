{ pkgs, ... }:
{

  imports = [ ./starship ];

  home = {

    packages = [
      pkgs.bashInteractive
      pkgs.coreutils
      pkgs.curl
      pkgs.jq
      pkgs.yq-go
      pkgs.fzf
      pkgs.bat
      pkgs.eza
      pkgs.patch
      pkgs.vips
    ];
  };

  programs = {

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      zplug = {
        enable = true;
      };
      initExtra = ''
        zplug "zsh-users/zsh-completions"
        zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:2
        zplug "plugins/git", from:oh-my-zsh
        zplug "agkozak/zsh-z"
        if ! zplug check; then
          zplug install
        fi
        zplug load

        alias cat=bat
        alias ls=eza
        source <(fzf --zsh)
        source <(starship init zsh)

        bindkey -v
      '';
    };
  };

}
