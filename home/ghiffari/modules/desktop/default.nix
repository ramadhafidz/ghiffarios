{ pkgs, ... }:

{
    imports = [
        ./konsole.nix
    ];

    home.packages = with pkgs; [
        kdePackages.kate
        nerd-fonts.jetbrains-mono
    ];
}
