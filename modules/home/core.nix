{
  pkgs,
  config,
  lib,
  ...
}:
{

  xdg.enable = true;

  home = {

    stateVersion = "24.05";
    enableNixpkgsReleaseCheck = true; # check for release version mismatch between Home Manager and Nixpkgs

    # Need to create aliases because Launchbar doesn't look through symlinks.
    activation.linkMacApplications = lib.hm.dag.entryAfter [ "writeBarrier" ] ''
      new_nix_apps="${config.home.homeDirectory}/Applications/Nix"
      rm -rf "$new_nix_apps"
      mkdir -p "$new_nix_apps"
      find -H -L "$newGenPath/home-files/Applications" -name "*.app" -type d -exec readlink -f '{}' + | while read -r app; do
        app_name=$(basename "$app")
        target_app="$new_nix_apps/$app_name"
        echo "Create alias $target_app"
        $DRY_RUN_CMD ${pkgs.mkalias}/bin/mkalias "$app" "$target_app"
      done
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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

}
