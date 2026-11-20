{ pkgs, ... }:

{
    imports = [
        ./mpv.nix
        ./arrpc.nix
    ];

    home.packages = with pkgs; [
        brave
        discord
        vscodium
        gpu-screen-recorder-gtk
    ];
}
