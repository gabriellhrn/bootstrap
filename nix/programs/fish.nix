{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fish
    ncurses
  ];

  programs.fish = {
    enable = true;
  };
}
