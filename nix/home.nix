{ config, pkgs, ... }:

{
  imports = [
    ./programs/programs.nix
  ];

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.username = "root";
  home.homeDirectory = "/root";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    curl
    firefox
    htop
    vim

    (nerdfonts.override { fonts = [ "Ubuntu" "UbuntuMono" ]; })
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
