{ pkgs, ... }:

{
  home.packages = [
    pkgs.neovim
  ];

  programs.neovim = {
    vimAlias = true;
  };
}
