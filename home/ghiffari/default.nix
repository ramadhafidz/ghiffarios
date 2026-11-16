{ ... }:

{
    imports = [
        ./modules/desktop
        ./modules/programs
    ];

    home.username = "ghiffari";
    home.homeDirectory = "/home/ghiffari";

    home.stateVersion = "26.05";

    programs.home-manager.enable = true;
}
