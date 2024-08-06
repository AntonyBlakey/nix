{ pkgs, ... }:
{

  home.packages = [
    pkgs.gh
    pkgs.lazygit
  ];

  programs.git = {
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

}
