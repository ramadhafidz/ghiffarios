{ ... }:

{
  imports = [
    ../../modules/gaming
    ./modules/desktop
    ./modules/programs
    ./modules/programs/zsh.nix
    ./modules/programs/fastfetch.nix
    ./modules/development
  ];

  home.username = "ghiffari";
  home.homeDirectory = "/home/ghiffari";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}