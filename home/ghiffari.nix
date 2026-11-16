{ pkgs, ... }:

{
    home.username = "ghiffari";
    home.homeDirectory = "/home/ghiffari";

    home.stateVersion = "26.05";

    home.packages = with pkgs; [
        kdePackages.kate
        brave
    ];

    programs.home-manager.enable = true;
}
