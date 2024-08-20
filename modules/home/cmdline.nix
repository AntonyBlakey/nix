{ pkgs, ... }:
{

  imports = [ ./starship ];

  home = {

    packages = [
      pkgs.curl
      pkgs.jq
      pkgs.yq
      pkgs.fzf
      pkgs.bat

      # pkgs.hyperfine
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
