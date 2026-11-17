{ ... }:

{
  imports = [
    ./modules/desktop
    ./modules/programs
    ./modules/development/neovim
    ./modules/development/agy
    ./modules/development/omp
  ];

  home.username = "ghiffari";
  home.homeDirectory = "/home/ghiffari";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
