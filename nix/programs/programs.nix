{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
  ];
}
